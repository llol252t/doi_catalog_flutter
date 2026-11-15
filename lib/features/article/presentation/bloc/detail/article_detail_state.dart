import '../../../../../common/network/load_exception.dart';
import '../../../domain/article_model.dart';

sealed class ArticleDetailState {
  const ArticleDetailState();
}

class ArticleDetailLoading extends ArticleDetailState {
  const ArticleDetailLoading();
}

class ArticleDetailLoaded extends ArticleDetailState {
  final ArticleModel article;
  const ArticleDetailLoaded(this.article);
}

class ArticleDetailNotFound extends ArticleDetailState {
  const ArticleDetailNotFound();
}

class ArticleDetailError extends ArticleDetailState {
  final LoadException exception;
  const ArticleDetailError(this.exception);
}