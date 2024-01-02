import 'package:flutter/material.dart';

class Icd10DiseasesSubcategoriesScreen extends StatelessWidget {
  final List subcategories;
  final String title;

  const Icd10DiseasesSubcategoriesScreen(
      {super.key, required this.subcategories, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          final sub = subcategories[index]["subcategories"];
          return ListTile(
            title: Text(subcategories[index]["code"]),
            subtitle: Column(children: [
              Text(subcategories[index]["name"]),
              sub.isNotEmpty ? Text(sub[0]["name"]) : const SizedBox.shrink(),
            ]),
          );
        },
      ),
    );
  }
}
