import '../../../common/network/load_exception.dart';
import '../domain/article_model.dart';
import '../domain/i_article_repository.dart';
import 'api/article_api.dart';
import 'data_sources/i_article_data_source.dart';
import 'mappers/article_mapper.dart';

class ArticleRepository implements IArticleRepository {
  ArticleRepository(this._dataSource);

  final IArticleDataSource _dataSource;

  @override
  Future<ArticlePage> getArticles({String query = '', String? cursor}) async {
    final response = await _dataSource.getWorks(query: query, cursor: cursor);
    final message = response.message;
    final nextCursor = message.nextCursor;
    return (
      articles: message.items.map((dto) => dto.toModel()).toList(),
      nextCursor:
          message.items.length >= ArticleApiClient.pageSize &&
              nextCursor != null &&
              nextCursor.isNotEmpty
          ? nextCursor
          : null,
    );
  }

  @override
  Future<ArticleModel?> getArticleById(String doi) async {
    try {
      final response = await _dataSource.getWork(doi);
      final dto = response.message;
      return dto.toModel();
    } on NotFoundException {
      return null;
    }
  }
}
