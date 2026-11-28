import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/network/load_exception.dart';
import '../../../domain/i_article_repository.dart';
import 'article_detail_state.dart';

class ArticleDetailCubit extends Cubit<ArticleDetailState> {
  final IArticleRepository _repository;

  ArticleDetailCubit(this._repository) : super(const ArticleDetailLoading());

  Future<void> load(String doi) async {
    if (doi.isEmpty) {
      emit(const ArticleDetailNotFound());
      return;
    }

    emit(const ArticleDetailLoading());
    try {
      final article = await _repository.getArticleById(doi);
      if (isClosed) return;
      if (article == null) {
        emit(const ArticleDetailNotFound());
      } else {
        emit(ArticleDetailLoaded(article));
      }
    } on LoadException catch (e) {
      if (isClosed) return;
      emit(ArticleDetailError(e));
    } catch (e) {
      if (isClosed) return;
      emit(const ArticleDetailError(BadResponseException()));
    }
  }
}
