import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'boxes/cached_api_query_box.dart';
import 'boxes/user_session_box.dart';
import 'boxes/user_session_persistent_box.dart';

enum EcDatabaseSchemaVersion {
  initialVersion(1);

  const EcDatabaseSchemaVersion(this.version);

  final int version;
}

class EcLocalDatabase {
  EcLocalDatabase._internal();

  static EcLocalDatabase get instance {
    return _instance;
  }

  static late final UserSessionBox _userSessionBox;
  static late final UserSessionPersistentBox _userSessionPersistentBox;
  static late final CachedApiQueryBox _cachedApiQueryBox;

  // Remove final modifier for support hot reload when re-initialize
  late Isar store;

  static final EcLocalDatabase _instance = EcLocalDatabase._internal();

  /// Create and open database
  Future<void> openDatabaseStore({
    Isar? storeIsolate,
    String dbName = 'ec_commerce.db',
  }) async {
    try {
      if (storeIsolate != null) {
        store = storeIsolate;
      } else {
        final db = Isar.getInstance(dbName);

        if (db != null) {
          store = db;
        } else {
          final dir = await _getIsarDir();

          store = await Isar.open(
            [
              UserSessionDbModelSchema,
              UserSessionPersistentDbModelSchema,
              CachedApiQueryDbModelSchema,
            ],
            name: dbName,
            directory: dir.path,
            inspector: () {
              return kDebugMode;
            }(),
          );
        }

        await performMigrationIfNeeded(store);

        log('Database Store opened successfully');
      }

      await initBoxes();
    } on Exception catch (e) {
      log('Exception from openDatabaseStore: $e');
    }
  }

  /// Get Isar directory for database storage
  Future<Directory> _getIsarDir() async {
    if (Platform.isAndroid) {
      return await getApplicationDocumentsDirectory();
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    } else {
      throw UnsupportedError(
        'Only mobile platforms (Android and iOS) are supported',
      );
    }
  }

  /// Initial all boxes
  Future<void> initBoxes() async {
    _userSessionBox = UserSessionBoxImpl(store);
    _userSessionPersistentBox = UserSessionPersistentBoxImpl(
      store,
      _userSessionBox,
    );
    _cachedApiQueryBox = CachedApiQueryBoxImpl(store);
  }

  bool isOpen() => store.isOpen;

  /// Close database
  Future<bool> close() => store.close();

  /// Size of database
  Future<int> size() => store.getSize();

  /// Clear data from database
  Future<void> clearDB() async {
    await store.writeTxn(() async {
      await store.userSessionDbModels.clear();
      await store.userSessionPersistentDbModels.clear();
      await store.cachedApiQueryDbModels.clear();
    });
  }

  /// Clear data from database synchronously
  void clearDBSync() {
    store.writeTxnSync(() {
      store.userSessionDbModels.clearSync();
      store.userSessionPersistentDbModels.clearSync();
      store.cachedApiQueryDbModels.clearSync();
    });
  }

  Future<void> clearDBWhenLogout() async {
    await store.writeTxn(() async {
      await store.userSessionDbModels.clear();
      await store.cachedApiQueryDbModels.clear();
    });
  }

  /// Checks if the database needs to be migrated to the latest schema version.
  ///
  /// If the database is already at the latest schema version, this function
  /// does nothing. If the database is not at the latest schema version, this
  /// function will perform the necessary migration steps.
  Future<void> performMigrationIfNeeded(Isar isar) async {
    // Check if the version is not set (new installation) or already at latest
    final prefs = await SharedPreferences.getInstance();
    final currentVersion = prefs.getInt('ec_db_version') ?? 1;

    switch (currentVersion) {
      case 1:
        await migrateV1ToV2(isar);
        break;
      case 2:
        // Already at latest version
        break;
    }

    // Update version
    await prefs.setInt('ec_db_version', 2);
  }

  /// Migrates the database from version 1 to 2.
  ///
  /// Currently, there is no migration needed, but future versions can use
  /// this function to perform the migration.
  Future<void> migrateV1ToV2(Isar isar) async {
    await isar.writeTxn(() async {
      await isar.userSessionDbModels.clear();
      await isar.userSessionPersistentDbModels.clear();
      await isar.cachedApiQueryDbModels.clear();
    });
  }

  UserSessionBox get userSessionBox => _userSessionBox;

  UserSessionPersistentBox get userSessionPersistentBox =>
      _userSessionPersistentBox;

  CachedApiQueryBox get cachedApiQueryBox => _cachedApiQueryBox;
}
