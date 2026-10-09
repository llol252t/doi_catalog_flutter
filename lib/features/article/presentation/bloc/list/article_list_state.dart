import '../../../domain/article_model.dart';

sealed class ArticleListState {
  const ArticleListState();
}

class ArticleListLoading extends ArticleListState {
  const ArticleListLoading();
}

class ArticleListLoaded extends ArticleListState {
  final List<ArticleModel> articles;
  const ArticleListLoaded(this.articles);
}

class ArticleListNotFound extends ArticleListState {
  const ArticleListNotFound();
}