import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:patho_helper_mobile/widgets/basic_screen.dart';


class ICD10Screen extends ConsumerWidget {
  const ICD10Screen({super.key});

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
                  hintText: 'Enter a disease name',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      //todo send request with disease name
                      //list of codes as a response
                    },
                  ),
                ))),
      ]),
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
