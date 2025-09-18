import 'dart:async';
import 'dart:developer';

class NotificationEntity {
  NotificationEntity({this.onTap});

  factory NotificationEntity.initialize() =>
      NotificationEntity(onTap: (response) => log('onTap: $response'));

  FutureOr<void> Function(NotificationsResponseEntity)? onTap;

  void setHandlers({
    FutureOr<void> Function(NotificationsResponseEntity)? onTap,
  }) {
    this.onTap = onTap ?? this.onTap;
  }
}

class NotificationsResponseEntity {
  NotificationsResponseEntity({required this.type, this.orderId = ''});

  final String type;
  final String orderId;
}

class NotificationResponseData {
  NotificationResponseData({this.type = '', this.orderId = ''});

  final String? type;
  final String? orderId;

  factory NotificationResponseData.fromJson(Map<String, dynamic> json) {
    return NotificationResponseData(
      type: json['type'] as String?,
      orderId: json['orderId'] as String?,
    );
  }
}
