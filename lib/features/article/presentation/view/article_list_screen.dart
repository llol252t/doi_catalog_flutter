  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:go_router/go_router.dart';

  import '../../../../l10n/app_localizations.dart';
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
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchHint,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<ArticleListCubit>().search('');
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                context.read<ArticleListCubit>().search(value);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ArticleListCubit, ArticleListState>(
              builder: (context, state) {
                return switch (state) {
                  ArticleListLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ArticleListLoaded(:final articles) => ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () => context.push('/article/${Uri.encodeComponent(article.doi)}'),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  if (article.authors.isNotEmpty)
                                    Text(
                                      article.authors.join(', '),
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
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
                                      const SizedBox(width: 8),
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
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ArticleListNotFound() => Center(
                      child: Text(
                        AppLocalizations.of(context)!.nothingFound,
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