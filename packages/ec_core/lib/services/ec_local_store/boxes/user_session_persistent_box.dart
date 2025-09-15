import 'package:isar/isar.dart';
import 'user_session_box.dart';

part 'user_session_persistent_box.g.dart';

@collection
@Name('UserSessionPersistent')
class UserSessionPersistentDbModel {
  UserSessionPersistentDbModel({
    this.appSettings,
    this.isFirstRun = false,
    this.userId,
  });

  Id id = Isar.autoIncrement;

  AppSettingsDbModel? appSettings;

  bool isFirstRun;

  final int? userId;
}

@embedded
class AppSettingsDbModel {
  AppSettingsDbModel({
    this.themeMode = 'system',
    this.language = 'en',
    this.notificationsEnabled = true,
    this.autoSyncEnabled = true,
  });

  String themeMode;
  String language;
  bool notificationsEnabled;
  bool autoSyncEnabled;
}

abstract class UserSessionPersistentBox {
  Future<bool> initIfAbsent();
  Future<AppSettingsDbModel?> fetchAppSettings();
  Future<bool> setAppSettings(AppSettingsDbModel? data);

  Future<bool> fetchIsFirstRun();
  Future<bool> setIsFirstRun({bool data = false});
}

class UserSessionPersistentBoxImpl extends UserSessionPersistentBox {
  UserSessionPersistentBoxImpl(this._store, this._userSessionBox);

  final Isar _store;
  final UserSessionBox _userSessionBox;

  Future<int?> _getUserId() async {
    final session = await _userSessionBox.getCurrentSession();

    // Assert that the user is logged in and has a valid userID
    assert(session?.userID != null, '''
      User is not logged in or session is invalid.
      Ensure the user is authenticated before accessing the app settings.''');

    return session!.userID;
  }

  @override
  Future<bool> initIfAbsent() async {
    final userId = await _getUserId();
    final userSessionPersistent =
        await _store.userSessionPersistentDbModels
            .filter()
            .userIdEqualTo(userId)
            .findFirst();

    if (userSessionPersistent == null) {
      await _store.writeTxn(() async {
        await _store.userSessionPersistentDbModels.put(
          UserSessionPersistentDbModel(userId: userId),
        );
      });
    }

    return true;
  }

  @override
  Future<AppSettingsDbModel?> fetchAppSettings() async {
    await initIfAbsent();
    final userId = await _getUserId();
    return (await _store.userSessionPersistentDbModels
            .filter()
            .userIdEqualTo(userId)
            .findFirst())
        ?.appSettings;
  }

  @override
  Future<bool> setAppSettings(AppSettingsDbModel? data) async {
    await initIfAbsent();
    final userId = await _getUserId();
    await _store.writeTxn(() async {
      final saved =
          await _store.userSessionPersistentDbModels
              .filter()
              .userIdEqualTo(userId)
              .findFirst();
      if (saved != null) {
        saved.appSettings = data;
        await _store.userSessionPersistentDbModels.put(saved);
      }
    });

    return true;
  }

  @override
  Future<bool> fetchIsFirstRun() async {
    await initIfAbsent();
    final userId = await _getUserId();
    return (await _store.userSessionPersistentDbModels
                .filter()
                .userIdEqualTo(userId)
                .findFirst())
            ?.isFirstRun ??
        false;
  }

  @override
  Future<bool> setIsFirstRun({bool data = false}) async {
    await initIfAbsent();
    final userId = await _getUserId();
    await _store.writeTxn(() async {
      final saved =
          await _store.userSessionPersistentDbModels
              .filter()
              .userIdEqualTo(userId)
              .findFirst();
      if (saved != null) {
        saved.isFirstRun = data;
        await _store.userSessionPersistentDbModels.put(saved);
      }
    });

    return true;
  }
}
