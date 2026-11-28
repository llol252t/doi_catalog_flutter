import 'package:dio/dio.dart';

import '../dto/work_response_dto.dart';
import '../dto/works_response_dto.dart';

class ArticleApiClient {
  ArticleApiClient(this._dio);

  final Dio _dio;

  static const pageSize = 20;

  Future<WorksResponseDto> getWorks({String query = '', String? cursor}) async {
    final json = await _getJson(
      '/works',
      queryParameters: {
        if (query.isNotEmpty) 'query': query,
        'rows': pageSize,
        'cursor': cursor ?? '*',
      },
    );
    return WorksResponseDto.fromJson(response);

  }

  Future<WorkResponseDto> getWork(String doi) async {
    final response = await _getJson('/works/${Uri.encodeComponent(doi)}');
    return WorkResponseDto.fromJson(response);
  }

  Future<Map<String, dynamic>> _getJson(
    String path, {
    Map<String, Object>? queryParameters,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
    );
    return response.data ?? (throw const FormatException('Пустой ответ'));
  }
}
