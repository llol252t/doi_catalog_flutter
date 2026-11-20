sealed class LoadException implements Exception {
  const LoadException();
}

/// Нет сети или сервер недоступен.
final class NoConnectionException extends LoadException {
  const NoConnectionException();
}

/// Сервер не ответил за отведённое время.
final class TimeoutLoadException extends LoadException {
  const TimeoutLoadException();
}

/// Сервер ответил 404: такой записи нет.
final class NotFoundException extends LoadException {
  const NotFoundException();
}

/// Сервер ответил ошибкой, кроме 404.
final class ServerException extends LoadException {
  const ServerException(this.statusCode);

  final int? statusCode;
}

/// Ответ пришёл, но разобрать его не удалось: другие поля, другие типы,
/// оборванный JSON.
final class BadResponseException extends LoadException {
  const BadResponseException();
}

/// Человекочитаемое сообщение для показа на экране ошибки.
extension LoadExceptionMessage on LoadException {
  String get message => switch (this) {
    NoConnectionException() => 'Не удалось подключиться к Crossref',
    TimeoutLoadException() => 'Сервер не ответил за отведённое время',
    NotFoundException() => 'Запись не найдена',
    ServerException(statusCode: 429) =>
      'Crossref получил слишком много запросов. Попробуйте чуть позже',
    ServerException(:final statusCode) =>
      statusCode != null ? 'Ошибка сервера ($statusCode)' : 'Ошибка сервера',
    BadResponseException() => 'Не удалось разобрать ответ сервера',
  };
}
