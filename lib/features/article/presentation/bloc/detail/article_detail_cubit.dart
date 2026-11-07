import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/i_article_repository.dart';
import 'article_detail_state.dart';

class ArticleDetailCubit extends Cubit<ArticleDetailState> {
  final IArticleRepository _repository;

  ArticleDetailCubit(this._repository) : super(const ArticleDetailLoading());

  Future<void> load(String doi) async {
    emit(const ArticleDetailLoading());
    try {
      final article = await _repository.getArticleById(doi);
      if (isClosed) return;
      if (article == null) {
        emit(const ArticleDetailNotFound());
      } else {
        emit(ArticleDetailLoaded(article));
      }
    } catch (e) {
      if (isClosed) return;
      emit(const ArticleDetailNotFound());
    }
  }
}
