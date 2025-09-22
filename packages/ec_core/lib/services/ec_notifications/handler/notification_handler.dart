import 'dart:developer';

import 'package:ec_core/services/ec_notifications/models/notification_models.dart';

class NotificationHandler {
  static void handleTapNavigate(
    Map<String, dynamic> data,
    NotificationEntity entity,
  ) {
    final response = NotificationResponseData.fromJson(data);
    final type = response.type ?? '';

    if (type.isNotEmpty) {
      entity.onTap?.call(
        NotificationsResponseEntity(
          type: type,
          orderId: response.orderId ?? '',
        ),
      );
    }
  }

  static void navigate({
    required NotificationsResponseEntity notification,
    void Function(NotificationsResponseEntity)? onOrderDetailsTap,
  }) {
    try {
      switch (notification.type) {
        case NotificationType.orderDetails:
          onOrderDetailsTap?.call(notification);
          break;
        default:
          log('Unknown notification type: ${notification.type}');
      }
    } catch (e) {
      log('Navigation error: $e');
    }
  }
}

class NotificationType {
  static const String orderDetails = 'order.details';
}
