import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/list/article_list_cubit.dart';
import '../bloc/list/article_list_state.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Статьи')),
      body: BlocBuilder<ArticleListCubit, ArticleListState>(
        builder: (context, state) {
          return switch (state) {
            ArticleListLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ArticleListLoaded(:final articles) => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
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
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ArticleListNotFound() => const Center(
                child: Text('Ничего не найдено'),
              ),
          };
        },
      ),
    );
  }
}