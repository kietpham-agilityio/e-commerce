import 'package:talker_flutter/talker_flutter.dart';

/// `WarningLog` - This class contains the basic structure of the warning log.
class WarningLog extends TalkerLog {
  WarningLog(String super.message);

  /// Log title
  @override
  String get title => 'warning';

  /// Log key
  @override
  String get key => getKey;

  /// Log color
  @override
  AnsiPen get pen => getPen;

  /// String representation for display
  @override
  String toString() => message ?? '';

  static get getPen => AnsiPen()..xterm(226); // Yellow color

  static get getKey => 'warning';
}
