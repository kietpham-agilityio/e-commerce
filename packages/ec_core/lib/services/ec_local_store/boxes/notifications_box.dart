import 'package:isar/isar.dart';

part 'notifications_box.g.dart';

@collection
@Name('notificaitons')
class NotificationsDbModel {
  NotificationsDbModel({
    this.id = 0,
    this.isNotificationEnabled,
    this.isNotifsEnabledDevice,
  });

  final Id id;

  bool? isNotificationEnabled;

  bool? isNotifsEnabledDevice;
}

abstract class NotificationsBox {
  Future<void> editBox({
    bool? isNotifsEnabledInApp,
    bool? isNotifsEnabledDevice,
  });

  Future<NotificationsDbModel?> getNotificationsBox();
}

class NotificationsBoxImpl extends NotificationsBox {
  NotificationsBoxImpl(this._store);

  final Isar _store;

  @override
  Future<void> editBox({
    bool? isNotifsEnabledInApp,
    bool? isNotifsEnabledDevice,
  }) async {
    await _store.writeTxn(() async {
      final saved = await _store.notificationsDbModels.get(0);
      if (saved == null) return;

      bool hasChanged = false;

      if (isNotifsEnabledInApp != null &&
          isNotifsEnabledInApp != saved.isNotificationEnabled) {
        saved.isNotificationEnabled = isNotifsEnabledInApp;
        hasChanged = true;
      }

      if (isNotifsEnabledDevice != null &&
          isNotifsEnabledDevice != saved.isNotifsEnabledDevice) {
        saved.isNotifsEnabledDevice = isNotifsEnabledDevice;
        hasChanged = true;
      }

      if (hasChanged) {
        await _store.notificationsDbModels.put(saved);
      }
    });
  }

  @override
  Future<NotificationsDbModel?> getNotificationsBox() {
    return _store.notificationsDbModels.get(0);
  }
}
