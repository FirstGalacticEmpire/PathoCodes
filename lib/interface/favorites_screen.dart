import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:patho_helper_mobile/widgets/basic_screen.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasicScreen(
      appContext: context,
      body: Container(),
      title: 'Ulubione',
      leftButton: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
