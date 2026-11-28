import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/network/load_exception.dart';
import '../../../domain/i_article_repository.dart';
import 'article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  final IArticleRepository _repository;

  String _lastQuery = '';
  Timer? _debounce;
  int _searchGeneration = 0;
  ArticleListLoaded? _unfilteredArticles;

  ArticleListCubit(this._repository) : super(const ArticleListLoading());

  void search([String query = '']) {
    final normalizedQuery = query.trim();
    _lastQuery = normalizedQuery;
    _debounce?.cancel();
    final generation = ++_searchGeneration;
    final cached = _unfilteredArticles;
    if (normalizedQuery.isEmpty && cached != null) {
      emit(cached);
      return;
    }

    emit(const ArticleListLoading());
    _debounce = Timer(
      const Duration(milliseconds: 400),
      () => _fetch(normalizedQuery, generation),
    );
  }

  Future<void> retry() {
    _debounce?.cancel();
    return _fetch(_lastQuery, ++_searchGeneration);
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! ArticleListLoaded ||
        current.nextCursor == null ||
        current.isLoadingMore) {
      return;
    }

    await _fetch(current.query, _searchGeneration, previous: current);
  }

  Future<void> _fetch(
    String query,
    int generation, {
    ArticleListLoaded? previous,
  }) async {
    emit(
      previous == null
          ? const ArticleListLoading()
          : ArticleListLoaded(
              previous.articles,
              query: query,
              nextCursor: previous.nextCursor,
              isLoadingMore: true,
            ),
    );

    try {
      final page = await _repository.getArticles(
        query: query,
        cursor: previous?.nextCursor,
      );
      if (isClosed || generation != _searchGeneration) return;

      if (previous == null && page.articles.isEmpty) {
        emit(const ArticleListNotFound());
        return;
      }

      final loaded = ArticleListLoaded(
        [if (previous != null) ...previous.articles, ...page.articles],
        query: query,
        nextCursor: page.nextCursor,
      );
      if (query.isEmpty) _unfilteredArticles = loaded;
      emit(loaded);
    } catch (error, stackTrace) {
      if (isClosed || generation != _searchGeneration) return;
      final exception = error is LoadException
          ? error
          : const BadResponseException();
      if (error is! LoadException) addError(error, stackTrace);

      emit(
        previous == null
            ? ArticleListError(exception)
            : ArticleListLoaded(
                previous.articles,
                query: query,
                nextCursor: previous.nextCursor,
                loadMoreError: exception,
              ),
      );
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
