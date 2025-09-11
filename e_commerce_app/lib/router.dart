import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:ec_core/logger/ui/theme.dart';

abstract class Routes {
  static const talker = '/talker';
}

final appRoutes = <String, WidgetBuilder>{
  // Routes.product: (context) => const ProductScreen(),
  // Routes.productsList: (context) => const ProductsScreen(),
  Routes.talker:
      (context) => TalkerScreen(
        talker: GetIt.instance<Talker>(),
        theme: talkerTheme,
        // customSettings: [
        //   CustomSettingsGroup(
        //     title: 'Website settings',
        //     enabled: true,
        //     onToggleEnabled: (_) {},
        //     items: [
        //       CustomSettingsItemBool(
        //         name: 'Disable remote logs',
        //         value: false,
        //         onChanged: (_) {},
        //       ),
        //     ],
        //   ),
        // ],
      ),
};
