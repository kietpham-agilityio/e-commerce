import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcAppBar(title: const EcHeadlineSmallText('Favorites')),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          final isFavoritesEnabled = state.flags.enableFavoritesPage ?? false;

          return isFavoritesEnabled
              ? const Center(
                child: EcBodyLargeText(
                  'Favorites content will be displayed here',
                ),
              )
              : const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: EcBodyLargeText(
                    'The Favorites feature is not available for now',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
        },
      ),
    );
  }
}
