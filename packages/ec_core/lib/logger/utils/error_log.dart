import 'package:talker_flutter/talker_flutter.dart';

/// `ErrorLog` - This class contains the basic structure of the error log.
class ErrorLog extends TalkerLog {
  ErrorLog(String super.message);

  /// Log title
  @override
  String get title => 'error';

  /// Log key
  @override
  String get key => getKey;

  /// Log color
  @override
  AnsiPen get pen => getPen;

  /// String representation for display
  @override
  String toString() => message ?? '';

  static get getPen => AnsiPen()..xterm(196); // Red color

  static get getKey => 'error';
}
