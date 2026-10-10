import '../../../domain/article_model.dart';

sealed class ArticleListState {
  const ArticleListState();
}

class ArticleListLoading extends ArticleListState {
  const ArticleListLoading();
}

class ArticleListLoaded extends ArticleListState {
  final List<ArticleModel> articles;
  final String query;
  const ArticleListLoaded(this.articles, {this.query = ''});
}

class ArticleListNotFound extends ArticleListState {
  const ArticleListNotFound();
}