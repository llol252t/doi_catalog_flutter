import 'article_model.dart';

abstract interface class IArticleRepository {
  Future<List<ArticleModel>> getArticles();
  Future<ArticleModel?> getArticleById(String doi);
}