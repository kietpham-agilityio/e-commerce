import 'package:talker_flutter/talker_flutter.dart';

/// `InfoLog` - This class contains the basic structure of the info log.
class InfoLog extends TalkerLog {
  InfoLog(String super.message);

  /// Log title
  @override
  String get title => 'info';

  /// Log key
  @override
  String get key => getKey;

  /// Log color
  @override
  AnsiPen get pen => getPen;

  /// String representation for display
  @override
  String toString() => message ?? '';

  static get getPen => AnsiPen()..xterm(33); // Blue color

  static get getKey => 'info';
}
