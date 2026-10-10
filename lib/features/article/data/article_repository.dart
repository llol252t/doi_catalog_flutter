import '../domain/article_model.dart';
import '../domain/i_article_repository.dart';
import 'mock_articles.dart';

class ArticleRepository implements IArticleRepository {
  @override
  Future<List<ArticleModel>> getArticles() async {
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

  @override
  Future<List<ArticleModel>> searchArticles(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (query.trim().isEmpty) return mockArticles;

    final lowerQuery = query.toLowerCase();
    return mockArticles.where((article) {
      final titleMatch = article.title.toLowerCase().contains(lowerQuery);
      final authorMatch = article.authors
          .any((author) => author.toLowerCase().contains(lowerQuery));
      final journalMatch = article.journal.toLowerCase().contains(lowerQuery);
      return titleMatch || authorMatch || journalMatch;
    }).toList();
  }
}