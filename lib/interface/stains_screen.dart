import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:patho_helper_mobile/widgets/basic_screen.dart';

class StainsScreen extends ConsumerWidget {
  const StainsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasicScreen(
      appContext: context,
      body: Placeholder(),
      title: 'Stains Screen',
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
