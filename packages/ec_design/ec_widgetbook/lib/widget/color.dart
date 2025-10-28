import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookFolder colorWidgetBooks() {
  return WidgetbookFolder(
    name: 'Color',
    children: [
      WidgetbookFolder(
        name: 'Admin',
        children: [
          colorPaletteComponent('Black', _getBlackColors()),
          colorPaletteComponent('White', _getWhiteColors()),
          colorPaletteComponent('Primary', _getAdminPrimaryColors()),
          colorPaletteComponent('Green', _getGreenColors()),
          colorPaletteComponent('Grey', _getGreyColors()),
          colorPaletteComponent('Error', _getErrorColors()),
        ],
      ),
      WidgetbookFolder(
        name: 'User',
        children: [
          colorPaletteComponent('Black', _getBlackColors()),
          colorPaletteComponent('White', _getWhiteColors()),
          colorPaletteComponent('Primary', _getUserPrimaryColors()),
          colorPaletteComponent('Green', _getGreenColors()),
          colorPaletteComponent('Grey', _getGreyColors()),
          colorPaletteComponent('Error', _getErrorColors()),
        ],
      ),
    ],
  );
}

WidgetbookComponent colorPaletteComponent(
  String paletteName,
  List<Map<String, dynamic>> colors,
) {
  return WidgetbookComponent(
    name: paletteName,
    useCases: [
      WidgetbookUseCase(
        name: paletteName,
        builder: (context) {
          return ECUiWidgetbook(
            copyCode: '''
            ''',
            child: ColorPaletteScreen(colors: colors, paletteName: paletteName),
          );
        },
      ),
    ],
  );
}

class ColorPaletteScreen extends StatelessWidget {
  final List<Map<String, dynamic>> colors;
  final String paletteName;

  const ColorPaletteScreen({
    super.key,
    required this.colors,
    required this.paletteName,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final color = colors[index];
        final Color bg = color['color'] as Color;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  color['name'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(color['hex'] as String),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Color palette data
List<Map<String, dynamic>> _getBlackColors() {
  return [
    {'name': 'black-50', 'hex': '#e9e9e9', 'color': const Color(0xFFE9E9E9)},
    {'name': 'black-100', 'hex': '#bababa', 'color': const Color(0xFFBABABA)},
    {'name': 'black-200', 'hex': '#999999', 'color': const Color(0xFF999999)},
    {'name': 'black-300', 'hex': '#6b6b6b', 'color': const Color(0xFF6B6B6B)},
    {'name': 'black-400', 'hex': '#4e4e4e', 'color': const Color(0xFF4E4E4E)},
    {'name': 'black-500', 'hex': '#222222', 'color': const Color(0xFF222222)},
    {'name': 'black-600', 'hex': '#1f1f1f', 'color': const Color(0xFF1F1F1F)},
    {'name': 'black-700', 'hex': '#181818', 'color': const Color(0xFF181818)},
    {'name': 'black-800', 'hex': '#131313', 'color': const Color(0xFF131313)},
    {'name': 'black-900', 'hex': '#0e0e0e', 'color': const Color(0xFF0E0E0E)},
  ];
}

List<Map<String, dynamic>> _getWhiteColors() {
  return [
    {'name': 'white-50', 'hex': '#ffffff', 'color': const Color(0xFFFFFFFF)},
    {'name': 'white-100', 'hex': '#ffffff', 'color': const Color(0xFFFFFFFF)},
    {'name': 'white-200', 'hex': '#ffffff', 'color': const Color(0xFFFFFFFF)},
    {'name': 'white-300', 'hex': '#ffffff', 'color': const Color(0xFFFFFFFF)},
    {'name': 'white-400', 'hex': '#ffffff', 'color': const Color(0xFFFFFFFF)},
    {'name': 'white-500', 'hex': '#ffffff', 'color': const Color(0xFFFFFFFF)},
    {'name': 'white-600', 'hex': '#e8e8e8', 'color': const Color(0xFFE8E8E8)},
    {'name': 'white-700', 'hex': '#b5b5b5', 'color': const Color(0xFFB5B5B5)},
    {'name': 'white-800', 'hex': '#8c8c8c', 'color': const Color(0xFF8C8C8C)},
    {'name': 'white-900', 'hex': '#6b6b6b', 'color': const Color(0xFF6B6B6B)},
  ];
}

List<Map<String, dynamic>> _getUserPrimaryColors() {
  return [
    {
      'name': 'userPrimary-50',
      'hex': '#fbeae9',
      'color': const Color(0xFFFBEAE9),
    },
    {
      'name': 'userPrimary-100',
      'hex': '#f4bfba',
      'color': const Color(0xFFF4BFBA),
    },
    {
      'name': 'userPrimary-200',
      'hex': '#eea099',
      'color': const Color(0xFFEEA099),
    },
    {
      'name': 'userPrimary-300',
      'hex': '#e7746b',
      'color': const Color(0xFFE7746B),
    },
    {
      'name': 'userPrimary-400',
      'hex': '#e2594e',
      'color': const Color(0xFFE2594E),
    },
    {
      'name': 'userPrimary-500',
      'hex': '#db3022',
      'color': const Color(0xFFDB3022),
    },
    {
      'name': 'userPrimary-600',
      'hex': '#c72c1f',
      'color': const Color(0xFFC72C1F),
    },
    {
      'name': 'userPrimary-700',
      'hex': '#9b2218',
      'color': const Color(0xFF9B2218),
    },
    {
      'name': 'userPrimary-800',
      'hex': '#781a13',
      'color': const Color(0xFF781A13),
    },
    {
      'name': 'userPrimary-900',
      'hex': '#5c140e',
      'color': const Color(0xFF5C140E),
    },
  ];
}

List<Map<String, dynamic>> _getAdminPrimaryColors() {
  return [
    {
      'name': 'adminPrimary-50',
      'hex': '#fef2e6',
      'color': const Color(0xFFFEF2E6),
    },
    {
      'name': 'adminPrimary-100',
      'hex': '#fbd7b0',
      'color': const Color(0xFFFBD7B0),
    },
    {
      'name': 'adminPrimary-200',
      'hex': '#f9c38a',
      'color': const Color(0xFFF9C38A),
    },
    {
      'name': 'adminPrimary-300',
      'hex': '#f6a854',
      'color': const Color(0xFFF6A854),
    },
    {
      'name': 'adminPrimary-400',
      'hex': '#f59733',
      'color': const Color(0xFFF59733),
    },
    {
      'name': 'adminPrimary-500',
      'hex': '#f27d00',
      'color': const Color(0xFFF27D00),
    },
    {
      'name': 'adminPrimary-600',
      'hex': '#dc7200',
      'color': const Color(0xFFDC7200),
    },
    {
      'name': 'adminPrimary-700',
      'hex': '#ac5900',
      'color': const Color(0xFFAC5900),
    },
    {
      'name': 'adminPrimary-800',
      'hex': '#854500',
      'color': const Color(0xFF854500),
    },
    {
      'name': 'adminPrimary-900',
      'hex': '#663500',
      'color': const Color(0xFF663500),
    },
  ];
}

List<Map<String, dynamic>> _getGreenColors() {
  return [
    {'name': 'green-50', 'hex': '#eaf6ee', 'color': const Color(0xFFEAF6EE)},
    {'name': 'green-100', 'hex': '#bde4c9', 'color': const Color(0xFFBDE4C9)},
    {'name': 'green-200', 'hex': '#9dd7af', 'color': const Color(0xFF9DD7AF)},
    {'name': 'green-300', 'hex': '#70c58b', 'color': const Color(0xFF70C58B)},
    {'name': 'green-400', 'hex': '#55ba75', 'color': const Color(0xFF55BA75)},
    {'name': 'green-500', 'hex': '#2aa952', 'color': const Color(0xFF2AA952)},
    {'name': 'green-600', 'hex': '#269a4b', 'color': const Color(0xFF269A4B)},
    {'name': 'green-700', 'hex': '#1e783a', 'color': const Color(0xFF1E783A)},
    {'name': 'green-800', 'hex': '#175d2d', 'color': const Color(0xFF175D2D)},
    {'name': 'green-900', 'hex': '#124722', 'color': const Color(0xFF124722)},
  ];
}

List<Map<String, dynamic>> _getGreyColors() {
  return [
    {'name': 'grey-50', 'hex': '#f9f9f9', 'color': const Color(0xFFF9F9F9)},
    {'name': 'grey-100', 'hex': '#e0e0e0', 'color': const Color(0xFFE0E0E0)},
    {'name': 'grey-200', 'hex': '#d1d1d1', 'color': const Color(0xFFD1D1D1)},
    {'name': 'grey-300', 'hex': '#bcbcbc', 'color': const Color(0xFFBCBCBC)},
    {'name': 'grey-400', 'hex': '#afafaf', 'color': const Color(0xFFAFAFAF)},
    {'name': 'grey-500', 'hex': '#9b9b9b', 'color': const Color(0xFF9B9B9B)},
    {'name': 'grey-600', 'hex': '#8d8d8d', 'color': const Color(0xFF8D8D8D)},
    {'name': 'grey-700', 'hex': '#6e6e6e', 'color': const Color(0xFF6E6E6E)},
    {'name': 'grey-800', 'hex': '#555555', 'color': const Color(0xFF555555)},
    {'name': 'grey-900', 'hex': '#414141', 'color': const Color(0xFF414141)},
  ];
}

List<Map<String, dynamic>> _getErrorColors() {
  return [
    {'name': 'error-50', 'hex': '#fee9e7', 'color': const Color(0xFFFEE9E7)},
    {'name': 'error-100', 'hex': '#fabab4', 'color': const Color(0xFFFABAB4)},
    {'name': 'error-200', 'hex': '#f89890', 'color': const Color(0xFFF89890)},
    {'name': 'error-300', 'hex': '#f5695e', 'color': const Color(0xFFF5695E)},
    {'name': 'error-400', 'hex': '#f34c3e', 'color': const Color(0xFFF34C3E)},
    {'name': 'error-500', 'hex': '#f01f0e', 'color': const Color(0xFFF01F0E)},
    {'name': 'error-600', 'hex': '#da1c0d', 'color': const Color(0xFFDA1C0D)},
    {'name': 'error-700', 'hex': '#aa160a', 'color': const Color(0xFFAA160A)},
    {'name': 'error-800', 'hex': '#841108', 'color': const Color(0xFF841108)},
    {'name': 'error-900', 'hex': '#650d06', 'color': const Color(0xFF650D06)},
  ];
}
