import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../di/di.dart';

class EcTalkerScreen extends StatelessWidget {
  const EcTalkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      // Try to get the main Talker instance
      if (LoggerDI.isTalkerRegistered(instanceName: 'main')) {
        return TalkerScreen(talker: LoggerDI.mainTalker);
      }

      // Fallback to any registered Talker instance
      if (DI.isRegistered<Talker>()) {
        return TalkerScreen(talker: DI.get<Talker>());
      }

      // If no Talker is registered, show an error message
      return Scaffold(
        appBar: AppBar(
          title: const Text('Talker Logs'),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Talker is not registered',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Please ensure logging is enabled during DI initialization.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      // Handle any other errors
      return Scaffold(
        appBar: AppBar(
          title: const Text('Talker Logs'),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Error accessing Talker logs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Error: $e', textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }
  }
}
