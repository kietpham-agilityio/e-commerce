import '../../services/ec_local_store/ec_local_store.dart';
import '../di_initializer.dart';

/// Local storage dependency injection configuration
/// Provides centralized local database registration and management
class LocalStorageDI {
  /// Register local database service
  static void registerLocalDatabase({
    String dbName = 'ec_commerce.db',
    bool enableInspector = false,
  }) {
    // Register the singleton instance
    DI.registerService<EcLocalDatabase>(
      EcLocalDatabase.instance,
      instanceName: 'main',
    );
  }

  /// Initialize and register local database
  static Future<void> initializeLocalDatabase({
    String dbName = 'ec_commerce.db',
    bool enableInspector = false,
  }) async {
    // Register the database instance
    registerLocalDatabase(dbName: dbName, enableInspector: enableInspector);

    // Get the registered instance and initialize it
    final database = DI.get<EcLocalDatabase>(instanceName: 'main');
    await database.openDatabaseStore(dbName: dbName);
  }

  /// Get local database instance
  static EcLocalDatabase getLocalDatabase({String instanceName = 'main'}) {
    return DI.get<EcLocalDatabase>(instanceName: instanceName);
  }

  /// Get main local database instance
  static EcLocalDatabase get mainDatabase =>
      getLocalDatabase(instanceName: 'main');

  /// Check if local database is registered
  static bool isLocalDatabaseRegistered({String instanceName = 'main'}) {
    return DI.isRegistered<EcLocalDatabase>(instanceName: instanceName);
  }

  /// Check if local database is open
  static bool isLocalDatabaseOpen({String instanceName = 'main'}) {
    if (!isLocalDatabaseRegistered(instanceName: instanceName)) {
      return false;
    }
    return getLocalDatabase(instanceName: instanceName).isOpen();
  }

  /// Get database size
  static Future<int> getDatabaseSize({String instanceName = 'main'}) async {
    final database = getLocalDatabase(instanceName: instanceName);
    return await database.size();
  }

  /// Clear all database data
  static Future<void> clearDatabase({String instanceName = 'main'}) async {
    final database = getLocalDatabase(instanceName: instanceName);
    await database.clearDB();
  }

  /// Clear session data only (useful for logout)
  static Future<void> clearSessionData({String instanceName = 'main'}) async {
    final database = getLocalDatabase(instanceName: instanceName);
    await database.clearDBWhenLogout();
  }

  /// Close local database
  static Future<bool> closeLocalDatabase({String instanceName = 'main'}) async {
    final database = getLocalDatabase(instanceName: instanceName);
    return await database.close();
  }

  /// Unregister local database
  static Future<void> unregisterLocalDatabase({
    String instanceName = 'main',
  }) async {
    if (isLocalDatabaseRegistered(instanceName: instanceName)) {
      final database = getLocalDatabase(instanceName: instanceName);

      // Close the database before unregistering
      if (database.isOpen()) {
        await database.close();
      }

      DI.unregister<EcLocalDatabase>(instanceName: instanceName);
    }
  }

  /// Dispose all local databases
  static Future<void> disposeAllLocalDatabases() async {
    final instanceNames = ['main'];

    for (final instanceName in instanceNames) {
      await unregisterLocalDatabase(instanceName: instanceName);
    }
  }

  /// Get user session box
  static UserSessionBox getUserSessionBox({String instanceName = 'main'}) {
    final database = getLocalDatabase(instanceName: instanceName);
    return database.userSessionBox;
  }

  /// Get user session persistent box
  static UserSessionPersistentBox getUserSessionPersistentBox({
    String instanceName = 'main',
  }) {
    final database = getLocalDatabase(instanceName: instanceName);
    return database.userSessionPersistentBox;
  }

  /// Get cached API query box
  static CachedApiQueryBox getCachedApiQueryBox({
    String instanceName = 'main',
  }) {
    final database = getLocalDatabase(instanceName: instanceName);
    return database.cachedApiQueryBox;
  }
}
