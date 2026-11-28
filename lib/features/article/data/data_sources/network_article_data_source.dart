import 'package:dio/dio.dart';
import 'package:doi_catalog_flutter/features/article/data/data_sources/i_article_data_source.dart';
import 'package:doi_catalog_flutter/features/article/data/dto/work_response_dto.dart';
import 'package:doi_catalog_flutter/features/article/data/dto/works_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../common/network/load_exception.dart';
import '../api/article_api.dart';

final class NetworkArticleDataSource implements IArticleDataSource {
  const NetworkArticleDataSource(this._api);

  final ArticleApiClient _api;

  @override
  Future<WorkResponseDto> getWork(String doi) => _guard(() => _api.getWork(doi));

  @override
  Future<WorksResponseDto> getWorks({String query = '', String? cursor}) =>
      _guard(() => _api.getWorks(query: query, cursor: cursor));


  /// await внутри try обязателен: без него ошибка Future пройдёт мимо catch.
  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw _fromDio(error);
    } on CheckedFromJsonException {
      // Поле не того типа или его нет: ответ не той формы, что описана в DTO.
      throw const BadResponseException();
    } on FormatException {
      throw const BadResponseException();
    }
  }

  LoadException _fromDio(DioException error) => switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => const TimeoutLoadException(),
    DioExceptionType.badResponse when error.response?.statusCode == 404 =>
    const NotFoundException(),
    DioExceptionType.badResponse => ServerException(error.response?.statusCode),
  // Оборванный или испорченный JSON dio отдаёт как unknown с
  // FormatException внутри.
    DioExceptionType.unknown when error.error is FormatException =>
    const BadResponseException(),
    DioExceptionType.connectionError ||
    DioExceptionType.badCertificate ||
    DioExceptionType.cancel ||
    DioExceptionType.unknown => const NoConnectionException(),
  };
}