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
      if (isClosed) return;
      if (articles.isEmpty) {
        emit(const ArticleListNotFound());
      } else {
        emit(ArticleListLoaded(articles));
      }
    } catch (e) {
      if (isClosed) return;
      emit(const ArticleListNotFound());
    }
  }

  Future<void> search(String query) async {
    emit(const ArticleListLoading());
    try {
      final articles = await _repository.searchArticles(query);
      if (isClosed) return;
      if (articles.isEmpty) {
        emit(const ArticleListNotFound());
      } else {
        emit(ArticleListLoaded(articles, query: query));
      }
    } catch (e) {
      if (isClosed) return;
      emit(const ArticleListNotFound());
    }
  }
}
