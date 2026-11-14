// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Crossref Articles';

  @override
  String get articlesTitle => 'Articles';

  @override
  String get articleTitle => 'Article';

  @override
  String get nothingFound => 'Nothing found';

  @override
  String get articleNotFound => 'Article not found';

  @override
  String get searchHint => 'Search';
}
