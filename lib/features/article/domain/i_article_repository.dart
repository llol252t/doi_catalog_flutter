import 'article_model.dart';

abstract interface class IArticleRepository {
  Future<List<ArticleModel>> getArticles({String query = ''});
  Future<ArticleModel?> getArticleById(String doi);
}