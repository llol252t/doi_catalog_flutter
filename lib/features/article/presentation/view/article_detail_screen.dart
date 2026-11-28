import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../l10n/load_exception_localization.dart';
import '../../domain/article_model.dart';
import '../../domain/i_article_repository.dart';
import '../bloc/detail/article_detail_cubit.dart';
import '../bloc/detail/article_detail_state.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key, required this.doi, this.preview});

  final String doi;
  final ArticleModel? preview;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) =>
          ArticleDetailCubit(context.read<IArticleRepository>())..load(doi),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.articleTitle)),
        body: BlocBuilder<ArticleDetailCubit, ArticleDetailState>(
          builder: (context, state) {
            final article = switch (state) {
              ArticleDetailLoaded(:final article) => article,
              _ => preview,
            };
            final status = switch (state) {
              ArticleDetailLoading() => const CircularProgressIndicator(),
              ArticleDetailNotFound() => Text(l10n.articleNotFound),
              ArticleDetailError(:final exception) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(exception.localizedMessage(l10n), textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () =>
                        context.read<ArticleDetailCubit>().load(doi),
                    child: Text(l10n.retry),
                  ),
                ],
              ),
              ArticleDetailLoaded() => null,
            };

            if (article == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: status,
                ),
              );
            }

            return _ArticleContent(article: article, status: status);
          },
        ),
      ),
    );
  }
}

class _ArticleContent extends StatelessWidget {
  const _ArticleContent({required this.article, required this.status});

  final ArticleModel article;
  final Widget? status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title.isEmpty ? article.doi : article.title,
            style: theme.textTheme.headlineSmall,
          ),
          if (article.authors.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(article.authors.join(', '), style: theme.textTheme.bodyMedium),
          ],
          if (article.year > 0 || article.journal.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              [
                if (article.year > 0) '${article.year}',
                if (article.journal.isNotEmpty) article.journal,
              ].join(' · '),
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
          if (article.type.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(article.type, style: theme.textTheme.labelSmall),
          ],
          if (article.abstractText.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(article.abstractText, style: theme.textTheme.bodyMedium),
          ],
          if (status case final widget?) ...[
            const SizedBox(height: 16),
            Center(child: widget),
          ],
        ],
      ),
    );
  }
}
