import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/navigation/app_router.dart';
import 'common/network/dio_client.dart';
import 'common/theme/app_theme.dart';
import 'common/theme/theme_cubit.dart';
import 'features/article/data/api/article_api.dart';
import 'features/article/data/article_repository.dart';
import 'features/article/data/data_sources/network_article_data_source.dart';
import 'features/article/domain/i_article_repository.dart';
import 'features/article/presentation/bloc/list/article_list_cubit.dart';
import 'l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiClient = ArticleApiClient(DioClient.create());
    final dataSource = NetworkArticleDataSource(apiClient);
    final repository = ArticleRepository(dataSource);

    return MultiBlocProvider(
      providers: [
        RepositoryProvider<IArticleRepository>.value(
          value: repository,
        ),

        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),

        BlocProvider<ArticleListCubit>(
          create: (context) => ArticleListCubit(repository)..search(),
        ),

      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            onGenerateTitle: (context) =>
            AppLocalizations.of(context)!.appTitle,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeMode,
            routerConfig: AppRouter.router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}