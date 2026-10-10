import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/i_article_repository.dart';
import 'article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  final IArticleRepository _repository;
  String _query = '';

  ArticleListCubit(this._repository) : super(const ArticleListLoading());

  Future<void> load() async {
    emit(const ArticleListLoading());
    try {
      final articles = await _repository.getArticles();
      _query = '';
      if (articles.isEmpty) {
        emit(const ArticleListNotFound());
      } else {
        emit(ArticleListLoaded(articles, query: _query));
      }
    } catch (e) {
      emit(const ArticleListNotFound());
    }
  }

  Future<void> search(String query) async {
    _query = query;
    emit(const ArticleListLoading());
    try {
      final articles = await _repository.searchArticles(query);
      if (articles.isEmpty) {
        emit(const ArticleListNotFound());
      } else {
        emit(ArticleListLoaded(articles, query: _query));
      }
    } catch (e) {
      emit(const ArticleListNotFound());
    }
  }
}