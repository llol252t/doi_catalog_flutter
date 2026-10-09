import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/i_article_repository.dart';
import 'article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  final IArticleRepository _repository;

  ArticleListCubit(this._repository) : super(const ArticleListLoading());

  Future<void> load() async {
    emit(const ArticleListLoading());
    try {
      final articles = await _repository.getArticles();
      if (articles.isEmpty) {
        emit(const ArticleListNotFound());
      } else {
        emit(ArticleListLoaded(articles));
      }
    } catch (e) {
      emit(const ArticleListNotFound());
    }
  }
}