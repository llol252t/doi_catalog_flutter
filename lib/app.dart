import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/article/data/article_repository.dart';
import 'features/article/domain/i_article_repository.dart';
import 'features/article/presentation/bloc/list/article_list_cubit.dart';
import 'features/article/presentation/view/article_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IArticleRepository>(
      create: (context) => ArticleRepository(),
      child: MaterialApp(
        title: 'Crossref Articles',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
        home: BlocProvider(
          create: (context) => ArticleListCubit(
            context.read<IArticleRepository>(),
          )..load(),
          child: const ArticleListScreen(),
        ),
      ),
    );
  }
}