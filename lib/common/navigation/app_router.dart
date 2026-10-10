import 'package:go_router/go_router.dart';

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
        path: '/article/:doi',
        name: 'detail',
        builder: (context, state) {
          final doi = Uri.decodeComponent(state.pathParameters['doi']!);
          return ArticleDetailScreen(doi: doi);
        },
      ),
    ],
  );
}