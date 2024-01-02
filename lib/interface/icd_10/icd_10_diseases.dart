import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Icd10DiseasesScreen extends StatelessWidget {
  const Icd10DiseasesScreen(
      {super.key, required this.subcategories, required this.title});
  final List subcategories;
  final String title;

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
          return ListTile(
            title: Text(subcategories[index]["code"]),
            subtitle: Text(subcategories[index]["name"]),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20),
            onTap: () {
              context.pushNamed('icd_10_diseases_subcategories',
                  pathParameters: {
                    'title': subcategories[index]["name"],
                  },
                  extra: subcategories[index]["subcategories"]);
            },
          );
        },
      ),
    );
  }
}
