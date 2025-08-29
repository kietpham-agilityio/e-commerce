import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/themes/app_colors.dart';
import 'package:ec_themes/themes/themes.dart';
import 'package:ec_themes/themes/widgets/switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<bool> _customSwitch1 = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _customSwitch2 = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _customSwitch1.dispose();
    _customSwitch2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final flavor = EcFlavor.current;

    return MaterialApp(
      title: flavor.appName,
      theme: EcDesignTheme.lightTheme,
      darkTheme: EcDesignTheme.darkTheme,
      home: Scaffold(
        backgroundColor: Color(0xffF9F9F9),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(flavor.appName),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                flavor.isAdmin ? 'Admin Flavor' : 'User Flavor',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Text('Bundle ID: ${flavor.bundleId}'),
              Text('API URL: ${flavor.apiBaseUrl}'),
              Text('Environment: ${flavor.environment}'),
              const SizedBox(height: 20),
              Text(
                flavor.isAdmin
                    ? 'This is the admin version with full access'
                    : 'This is the user version with essential features',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      flavor.isAdmin
                          ? Colors.red.withValues(alpha: 0.1)
                          : Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: flavor.isAdmin ? Colors.red : Colors.blue,
                    width: 2,
                  ),
                ),
                child: Text(
                  'Current Flavor: ${flavor.displayName}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: flavor.isAdmin ? Colors.red : Colors.blue,
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _customSwitch1,
                builder: (context, value, widget) {
                  return EcSwitch(
                    themeType: ECThemeType.user,
                    value: value,
                    onChanged: (val) => _customSwitch1.value = val,
                  );
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _customSwitch2,
                builder: (context, value, widget) {
                  return EcSwitch(
                    themeType: ECThemeType.user,
                    value: value,
                    onChanged: (val) => _customSwitch2.value = val,
                  );
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _customSwitch2,
                builder: (context, value, widget) {
                  return CupertinoSwitch(
                    value: value,
                    onChanged: (val) => _customSwitch2.value = val,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
