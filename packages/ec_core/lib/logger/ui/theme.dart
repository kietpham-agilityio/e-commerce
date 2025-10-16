import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../utils/good_log.dart';
import '../utils/error_log.dart';
import '../utils/warning_log.dart';
import '../utils/info_log.dart';
import '../utils/success_log.dart';

final lightTheme = ThemeData(
  primaryColor: Colors.purple,
  primarySwatch: Colors.purple,
  scaffoldBackgroundColor: const Color(0xffffffff),
  cardColor: Colors.white,
  appBarTheme: const AppBarTheme(color: Colors.white),
);

const cardShadow = [
  BoxShadow(
    color: Color(0x11272749),
    blurRadius: 16,
    offset: Offset(0, 3),
    spreadRadius: 0,
  ),
];

final talkerTheme = TalkerScreenTheme(
  textColor: Colors.black,
  backgroundColor: Colors.white,
  cardColor: Colors.grey[200]!,
  logColors: {
    // Custom log types
    GoodLog.getKey: const Color(0xff1B5E20), // Green for good logs
    ErrorLog.getKey: const Color(0xffF44336), // Red for error logs
    WarningLog.getKey: const Color(0xffFF9800), // Orange for warning logs
    InfoLog.getKey: const Color(0xff2196F3), // Blue for info logs
    SuccessLog.getKey: const Color(0xff1B5E20), // Darker green
    // Built-in Talker log types (using string keys)
    'http-response': const Color(0xff1B5E20), // Green for HTTP responses
    'http-request': Colors.black, // Blue for HTTP requests
    'http-error': const Color(0xffF44336), // Red for HTTP errors
    'error': const Color(0xffF44336), // Red for errors
    'critical': const Color(0xffB71C1C), // Dark red for critical errors
    'warning': const Color(0xffFF9800), // Orange for warnings
    'info': const Color(0xff2196F3), // Blue for info
    'debug': const Color(0xff9E9E9E), // Gray for debug
    'verbose': const Color(0xff757575), // Light gray for verbose
    'good': const Color(0xff1B5E20), // Green for good logs
    'route': const Color(0xff9C27B0), // Purple for route logs
  },
);
