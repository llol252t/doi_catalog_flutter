import '../../../../../common/network/load_exception.dart';
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
  final String? nextCursor;
  final bool isLoadingMore;
  final LoadException? loadMoreError;

  const ArticleListLoaded(
    this.articles, {
    required this.query,
    this.nextCursor,
    this.isLoadingMore = false,
    this.loadMoreError,
  });
}

class ArticleListNotFound extends ArticleListState {
  const ArticleListNotFound();
}

final class ArticleListError extends ArticleListState {
  final LoadException exception;
  const ArticleListError(this.exception);
}
