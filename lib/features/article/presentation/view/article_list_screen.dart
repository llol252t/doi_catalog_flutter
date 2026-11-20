import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../common/network/load_exception.dart';
import '../../../../common/theme/theme_cubit.dart';
import '../bloc/list/article_list_cubit.dart';
import '../bloc/list/article_list_state.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.articlesTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeCubit>().toggle(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _searchController,
              builder: (context, value, child) => TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: value.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            context.read<ArticleListCubit>().search('');
                          },
                        )
                      : null,
                ),
                onChanged: context.read<ArticleListCubit>().search,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ArticleListCubit, ArticleListState>(
              builder: (context, state) {
                return switch (state) {
                  ArticleListLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  ArticleListLoaded loaded => ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount:
                        loaded.articles.length +
                        (loaded.nextCursor == null ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index == loaded.articles.length) {
                        return _LoadMoreFooter(state: loaded);
                      }
                      final article = loaded.articles[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => context.pushNamed(
                            'detail',
                            queryParameters: {'doi': article.doi},
                            extra: article,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                                const SizedBox(height: 8),
                                if (article.authors.isNotEmpty)
                                  Text(
                                    article.authors.join(', '),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                if (article.year > 0 ||
                                    article.journal.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      if (article.year > 0)
                                        Text(
                                          article.year.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                        ),
                                      if (article.year > 0 &&
                                          article.journal.isNotEmpty)
                                        const SizedBox(width: 8),
                                      if (article.journal.isNotEmpty)
                                        Expanded(
                                          child: Text(
                                            '· ${article.journal}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ArticleListNotFound() => Center(
                    child: Text(AppLocalizations.of(context)!.nothingFound),
                  ),
                  ArticleListError(:final exception) => Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(exception.message),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: () =>
                              context.read<ArticleListCubit>().retry(),
                          child: Text(AppLocalizations.of(context)!.retry),
                        ),
                      ],
                    ),
                  ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadMoreFooter extends StatelessWidget {
  const _LoadMoreFooter({required this.state});

  final ArticleListLoaded state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final error = state.loadMoreError;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: state.isLoadingMore
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (error != null)
                  Text(error.message, textAlign: TextAlign.center),
                OutlinedButton(
                  onPressed: context.read<ArticleListCubit>().loadMore,
                  child: Text(error == null ? l10n.loadMore : l10n.retry),
                ),
              ],
            ),
    );
  }
}
