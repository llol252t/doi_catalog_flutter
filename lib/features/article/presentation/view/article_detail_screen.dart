import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';


import '../../domain/i_article_repository.dart';
import '../bloc/detail/article_detail_cubit.dart';
import '../bloc/detail/article_detail_state.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String doi;

  const ArticleDetailScreen({super.key, required this.doi});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleDetailCubit(
        context.read<IArticleRepository>(),
      )..load(doi),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: Text(AppLocalizations.of(context)!.articleTitle),
        ),
        body: BlocBuilder<ArticleDetailCubit, ArticleDetailState>(
          builder: (context, state) {
            return switch (state) {
              ArticleDetailLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              ArticleDetailLoaded(:final article) => SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 12),
                      if (article.authors.isNotEmpty)
                        Text(
                          article.authors.join(', '),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      const SizedBox(height: 12),
                      Text(
                        '${article.year} · ${article.journal}',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        article.type,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      if (article.abstractText.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          article.abstractText,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ],
                  ),
                ),
              ArticleDetailNotFound() => Center(
                  child: Text(AppLocalizations.of(context)!.articleNotFound),
                ),
            };
          },
        ),
      ),
    );
  }
}