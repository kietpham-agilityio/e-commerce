/// Base service class for dependency injection
/// Provides common interface for all services in the application
abstract class BaseService {
  /// Initialize the service
  /// Called when the service is first registered or when DI is initialized
  Future<void> initialize() async {}

  /// Dispose the service
  /// Called when the service is being removed from DI or when DI is disposed
  Future<void> dispose() async {}
}

