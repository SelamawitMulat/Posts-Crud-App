// Native system runtime exceptions thrown during data collection
class ServerException implements Exception {
  final String message;
  const ServerException(
      [this.message = 'An unexpected server error occurred.']);
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Local cache sync operation dropped.']);
}
