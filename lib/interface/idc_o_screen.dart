import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:patho_helper_mobile/widgets/basic_screen.dart';

class ICDOScreen extends ConsumerWidget {
  const ICDOScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = TextEditingController();
    return BasicScreen(
      appContext: context,
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  hintText: 'Search for a code here',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      //todo send request with a code
                      //list as a response
                    },
                  ),
                ))),
      ]),
      title: 'ICD-O Screen',
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
