import 'dart:async';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:ec_core/services/ec_notifications/config/notification_config.dart';
import 'package:ec_core/services/ec_notifications/models/notification_models.dart';

@pragma('vm:entry-point')
class NotificationsService {
  static NotificationEntity entity = NotificationEntity.initialize();

  static AwesomeNotifications awesomeNotifications = AwesomeNotifications();

  static AwesomeNotificationsFcm awesomeFCM = AwesomeNotificationsFcm();

  Future<void> initialize() async {
    await _setupNotification();
    await _requestNotificationPermission();
    await _setupFCM();
  }

  Future<void> _setupNotification() async {
    await awesomeNotifications.initialize(
      null,
      [
        NotificationChannel(
          channelKey: NotificationConfig.channelKey,
          channelName: NotificationConfig.channelName,
          channelDescription: NotificationConfig.channelDescription,
          channelGroupKey: NotificationConfig.channelGroupKey,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          playSound: true,
          channelShowBadge: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: NotificationConfig.channelGroupKey,
          channelGroupName: NotificationConfig.channelGroupName,
        ),
      ],
      debug: true,
    );
  }

  Future<void> _requestNotificationPermission() async {
    awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        awesomeNotifications.requestPermissionToSendNotifications();

        // TODO: handle update notification box
        log('Handle update notification box');
      }
    });
  }

  NotificationsService configure({
    FutureOr<void> Function(NotificationsResponseEntity)? onTap,
  }) {
    entity.setHandlers(onTap: onTap);
    return this;
  }

  Future<void> _setupFCM() async {
    await awesomeFCM.initialize(
      onFcmTokenHandle: myFcmTokenHandle,
      onFcmSilentDataHandle: mySilentDataHandle,
      onNativeTokenHandle: myNativeTokenHandle,
      // licenseKeys: null,
      debug: true,
    );
  }

  static Future<void> setNotificationListeners() async {
    await awesomeNotifications.setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
    );
  }

  // when receiving FCM token
  @pragma('vm:entry-point')
  static Future<void> myFcmTokenHandle(String token) async {
    log('FCM Token Handle: $token');
  }

  // when receiving FCM silent data
  @pragma('vm:entry-point')
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    log('Silent Data: ${silentData.data}');
    final data = silentData.data;

    log(
      '[FCM Silent] Type: ${data?['type']}, accountId: ${data?['accountId']}, accountName: ${data?['accountName']}',
    );
  }

  // when receiving native token
  @pragma('vm:entry-point')
  static Future<void> myNativeTokenHandle(String token) async {
    log('Native Token Handle: $token');
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    log('Received Action: ${receivedAction.toMap()}');
  }

  @pragma('vm:entry-point')
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction? receivedAction,
  ) async {
    log('Dismissed Action: ${receivedAction?.toMap()}');
  }

  @pragma('vm:entry-point')
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification? receivedNotification,
  ) async {
    log('🔢 onNotificationCreatedMethod');
  }

  @pragma('vm:entry-point')
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification? receivedNotification,
  ) async {
    log('🔢 onNotificationDisplayedMethod');
  }
}
