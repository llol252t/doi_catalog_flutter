import 'article_model.dart';

typedef ArticlePage = ({List<ArticleModel> articles, String? nextCursor});

abstract interface class IArticleRepository {
  Future<ArticlePage> getArticles({String query = '', String? cursor});
  Future<ArticleModel?> getArticleById(String doi);
}
