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
}
