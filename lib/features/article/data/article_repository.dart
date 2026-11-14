import '../domain/article_model.dart';
import '../domain/i_article_repository.dart';
import 'mock_articles.dart';

class ArticleRepository implements IArticleRepository {
  @override
  Future<List<ArticleModel>> getArticles({String query = ''}) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return mockArticles;

    final lowerQuery = trimmedQuery.toLowerCase();
    return mockArticles.where((article) {
      final titleMatch = article.title.toLowerCase().contains(lowerQuery);
      final authorMatch = article.authors
          .any((author) => author.toLowerCase().contains(lowerQuery));
      final journalMatch = article.journal.toLowerCase().contains(lowerQuery);
      return titleMatch || authorMatch || journalMatch;
    }).toList();
  }

  @override
  Future<ArticleModel?> getArticleById(String doi) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return mockArticles.firstWhere((a) => a.doi == doi);
    } catch (e) {
      return null;
    }
  }
}
//
// /// Репозиторий на сети. В ЛР2 здесь были моки, интерфейс с тех пор не
// /// изменился.
// ///
// /// Репозиторий берёт DTO у датасорса и отдаёт наверх только модели
// /// приложения. Ошибки датасорса уже переведены в LoadException, их репозиторий
// /// пропускает наверх как есть.
// final class PokemonRepository implements IPokemonRepository {
//   PokemonRepository(this._dataSource);
//
//   final IPokemonDataSource _dataSource;
//
//   /// Имена всех записей для поиска. Загружаются при первом поиске и живут в
//   /// памяти, пока работает приложение.
//   List<String>? _allNames;
//
//   static const int _searchLimit = 20;
//
//   @override
//   Future<List<PokemonModel>> getPokemons({
//     required int offset,
//     required int limit,
//   }) async {
//     final page = await _dataSource.getPokemonPage(offset: offset, limit: limit);
//     // В странице только имена. Типы и картинку отдаёт адрес каждой записи,
//     // поэтому за страницей идут ещё [limit] запросов, все сразу.
//     return _loadAll([for (final item in page.results) item.name]);
//   }
//
//   @override
//   Future<PokemonDetailsModel> getDetails(int id) async {
//     final PokemonDto pokemon;
//     final PokemonSpeciesDto species;
//     try {
//       // Запись и её вид не зависят друг от друга: два запроса идут
//       // параллельно, ждём оба.
//       (pokemon, species) = await (
//       _dataSource.getPokemon('$id'),
//       _dataSource.getSpecies(id),
//       ).wait;
//     } on ParallelWaitError<
//         (PokemonDto?, PokemonSpeciesDto?),
//         (AsyncError?, AsyncError?)
//     > catch (error) {
//       // .wait у пары бросает не исходную ошибку, а ParallelWaitError с
//       // ошибками обоих запросов. Наверх отдаём первую, это LoadException.
//       final first = (error.errors.$1 ?? error.errors.$2)!;
//       Error.throwWithStackTrace(first.error, first.stackTrace);
//     }
//
//     final chain = await _dataSource.getEvolutionChain(species.evolutionChainId);
//     final evolution = await _loadAll([
//       for (final stageId in chain.speciesIds) '$stageId',
//     ]);
//     return PokemonDetailsModel(
//       pokemon: pokemon.toModel(),
//       genus: species.englishGenus,
//       flavorText: species.englishFlavorText,
//       evolution: evolution,
//     );
//   }
//
//   @override
//   Future<List<PokemonModel>> searchPokemons(String query) async {
//     // Поиска по имени на сервере нет. Список всех имён весит около 100 КБ,
//     // его загружаем один раз и ищем в памяти.
//     final names = _allNames ??= await _loadAllNames();
//     final needle = query.trim().toLowerCase();
//     return _loadAll(
//       names.where((name) => name.contains(needle)).take(_searchLimit),
//     );
//   }
//
//   Future<List<String>> _loadAllNames() async {
//     final first = await _dataSource.getPokemonPage(offset: 0, limit: 1);
//     final all = await _dataSource.getPokemonPage(offset: 0, limit: first.count);
//     return [for (final item in all.results) item.name];
//   }
//
//   /// Записи по именам или номерам, все запросы сразу. Future.wait, в отличие
//   /// от .wait у пары, пробрасывает исходную ошибку первого упавшего запроса.
//   Future<List<PokemonModel>> _loadAll(Iterable<String> idsOrNames) async {
//     final dtos = await Future.wait([
//       for (final idOrName in idsOrNames) _dataSource.getPokemon(idOrName),
//     ]);
//     return [for (final dto in dtos) dto.toModel()];
//   }
// }