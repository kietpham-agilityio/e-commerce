import 'package:talker_flutter/talker_flutter.dart';

/// `SuccessLog` - This class contains the basic structure of the success log.
class SuccessLog extends TalkerLog {
  SuccessLog(String super.message);

  /// Log title
  @override
  String get title => 'success';

  /// Log key
  @override
  String get key => getKey;

  /// Log color
  @override
  AnsiPen get pen => getPen;

  /// String representation for display
  @override
  String toString() => message ?? '';

  static get getPen => AnsiPen()..xterm(28); // Dark green color

  static get getKey => 'success';
}
