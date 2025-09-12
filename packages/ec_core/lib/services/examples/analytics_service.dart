import 'package:ec_core/ec_core.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Example analytics service using DI
class AnalyticsService extends BaseService {
  late final Talker _logger;
  late final EcFlavor _flavor;

  @override
  Future<void> initialize() async {
    _logger = DI.logger;
    _flavor = DI.currentFlavor;

    _logger.info('AnalyticsService initialized for ${_flavor.displayName}');
  }

  @override
  Future<void> dispose() async {
    _logger.info('AnalyticsService disposed');
  }

  /// Track user event
  void trackEvent(String eventName, Map<String, dynamic> properties) {
    _logger.info('Tracking event: $eventName with properties: $properties');

    // Different tracking based on flavor
    if (_flavor.isAdmin) {
      _trackAdminEvent(eventName, properties);
    } else {
      _trackUserEvent(eventName, properties);
    }
  }

  /// Track admin-specific event
  void _trackAdminEvent(String eventName, Map<String, dynamic> properties) {
    _logger.debug('Admin event tracked: $eventName');
    // Admin-specific tracking logic
  }

  /// Track user-specific event
  void _trackUserEvent(String eventName, Map<String, dynamic> properties) {
    _logger.debug('User event tracked: $eventName');
    // User-specific tracking logic
  }

  /// Track page view
  void trackPageView(String pageName) {
    trackEvent('page_view', {'page': pageName});
  }

  /// Track user action
  void trackUserAction(String action, Map<String, dynamic> properties) {
    trackEvent('user_action', {'action': action, ...properties});
  }
}
