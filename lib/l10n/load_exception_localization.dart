import '../common/network/load_exception.dart';
import 'app_localizations.dart';

extension LoadExceptionLocalization on LoadException {
  String localizedMessage(AppLocalizations l10n) => switch (this) {
    NoConnectionException() => l10n.crossrefConnectionError,
    TimeoutLoadException() => l10n.requestTimeout,
    NotFoundException() => l10n.recordNotFound,
    ServerException(statusCode: 429) => l10n.crossrefRateLimit,
    ServerException(statusCode: final int code) =>
      l10n.serverErrorWithStatus(code),
    ServerException() => l10n.serverError,
    BadResponseException() => l10n.invalidServerResponse,
  };
}
