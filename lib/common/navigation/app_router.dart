import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/article/domain/article_model.dart';
import '../../features/article/presentation/view/article_detail_screen.dart';
import '../../features/article/presentation/view/article_list_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'list',
        builder: (context, state) => const ArticleListScreen(),
      ),
      GoRoute(
        path: '/article',
        name: 'detail',
        builder: (context, state) {
          final doi = state.uri.queryParameters['doi'] ?? '';
          final extra = state.extra;
          return ArticleDetailScreen(
            key: ValueKey(doi),
            doi: doi,
            preview: extra is ArticleModel && extra.doi == doi ? extra : null,
          );
        },
      ),
    ],
  );
}
