import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../di/di.dart';

class PresentationWidget extends StatelessWidget {
  const PresentationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(talker: DI.get<Talker>());
  }
}
