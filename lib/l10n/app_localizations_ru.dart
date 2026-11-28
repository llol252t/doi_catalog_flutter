// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Статьи Crossref';

  @override
  String get articlesTitle => 'Статьи';

  @override
  String get articleTitle => 'Статья';

  @override
  String get nothingFound => 'Ничего не найдено';

  @override
  String get articleNotFound => 'Статья не найдена';

  @override
  String get searchHint => 'Поиск';

  @override
  String get loadMore => 'Загрузить ещё';

  @override
  String get retry => 'Повторить';

  @override
  String get crossrefConnectionError => 'Не удалось подключиться к Crossref';

  @override
  String get requestTimeout => 'Сервер не ответил за отведённое время';

  @override
  String get recordNotFound => 'Запись не найдена';

  @override
  String get crossrefRateLimit =>
      'Crossref получил слишком много запросов. Попробуйте чуть позже';

  @override
  String get serverError => 'Ошибка сервера';

  @override
  String serverErrorWithStatus(int statusCode) {
    return 'Ошибка сервера ($statusCode)';
  }

  @override
  String get invalidServerResponse => 'Не удалось разобрать ответ сервера';
}
