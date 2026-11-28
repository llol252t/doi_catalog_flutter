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

  @override
  String get loadMore => 'Load more';

  @override
  String get retry => 'Retry';

  @override
  String get crossrefConnectionError => 'Could not connect to Crossref';

  @override
  String get requestTimeout => 'The server did not respond in time';

  @override
  String get recordNotFound => 'Record not found';

  @override
  String get crossrefRateLimit =>
      'Crossref received too many requests. Try again shortly';

  @override
  String get serverError => 'Server error';

  @override
  String serverErrorWithStatus(int statusCode) {
    return 'Server error ($statusCode)';
  }

  @override
  String get invalidServerResponse => 'Could not read the server response';
}
