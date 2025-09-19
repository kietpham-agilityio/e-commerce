import 'package:flutter/material.dart';
import 'package:ec_themes/themes/themes.dart';
import '../ec_app_bar.dart';

/// Example page demonstrating the tab bar widget
class TabBarExamplePage extends StatefulWidget {
  const TabBarExamplePage({super.key});

  @override
  State<TabBarExamplePage> createState() => _TabBarExamplePageState();
}

class _TabBarExamplePageState extends State<TabBarExamplePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: EcAppBar(titleText: 'Tab Bar Examples'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EcTabBar(
              tabs: const [
                EcTab(text: 'Women'),
                EcTab(text: 'Men'),
                EcTab(text: 'Kids'),
              ],
              selectedIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
