import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:patho_helper_mobile/widgets/basic_screen.dart';

class ICD10Screen extends ConsumerWidget {
  const ICD10Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasicScreen(
      appContext: context,
      body: Placeholder(),
      title: 'ICD-10 Screen',
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
