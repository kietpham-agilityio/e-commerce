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
    GoodLog.getKey: const Color(0xff4CAF50), // Green for good logs
    ErrorLog.getKey: const Color(0xffF44336), // Red for error logs
    WarningLog.getKey: const Color(0xffFF9800), // Orange for warning logs
    InfoLog.getKey: const Color(0xff2196F3), // Blue for info logs
    SuccessLog.getKey: const Color(0xff2E7D32), // Dark green for success logs
  },
);
