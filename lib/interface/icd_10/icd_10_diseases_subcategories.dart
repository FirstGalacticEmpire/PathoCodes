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
          // final sub = subcategories[index]["subcategories"];
          var item = subcategories[index];
          List subs = item["subcategories"] ?? [];
          return ListTile(
            title: Text(subcategories[index]["code"]),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(subcategories[index]["name"]),
              const SizedBox(height: 10),
              ...subs.map((code) {
                return code != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              code['code'] != ""
                                  ? Text(code['code'])
                                  : const SizedBox.shrink(),
                              Text(code['name'])
                            ]))
                    : const SizedBox.shrink();
              }).toList(),
              // sub.isNotEmpty ? Text(sub[0]["name"]) : const SizedBox.shrink(),
              const Divider(
                height: 20,
                thickness: 0.5,
                indent: 0,
                endIndent: 0,
              ),
            ]),
          );
        },
      ),
    );
  }
}
