import 'package:doi_catalog_flutter/features/article/data/dto/work_response_dto.dart';
import '../dto/works_response_dto.dart';

abstract interface class IArticleDataSource {

  Future<WorkResponseDto> getWork(String dio);

  Future<WorksResponseDto> getWorks({String query = '', String? cursor});
}