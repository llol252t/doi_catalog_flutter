import '../domain/article_model.dart';
import '../domain/i_article_repository.dart';
import 'mock_articles.dart';

class ArticleRepository implements IArticleRepository {
  @override
  Future<List<ArticleModel>> getArticles() async {
    // Имитация задержки сети (чтобы UI успел показать Loading)
    await Future.delayed(const Duration(milliseconds: 300));
    return mockArticles;
  }

  @override
  Future<ArticleModel?> getArticleById(String doi) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return mockArticles.firstWhere((a) => a.doi == doi);
    } catch (e) {
      return null;
    }
  }
}