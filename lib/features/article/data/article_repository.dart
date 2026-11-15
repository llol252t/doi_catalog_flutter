import '../../../common/network/load_exception.dart';
import '../domain/article_model.dart';
import '../domain/i_article_repository.dart';
import '../data/data_sources/i_article_data_source.dart';
import 'mappers/article_mapper.dart';

class ArticleRepository implements IArticleRepository {
  ArticleRepository(this._dataSource);

  final IArticleDataSource _dataSource;

  @override
  Future<List<ArticleModel>> getArticles({String query = ''}) async {

    final response = await _dataSource.getWorks(query: query);
    final items = response.message.items;
    return items.map((dto) => dto.toModel()).toList();
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