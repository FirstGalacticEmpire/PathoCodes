import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Icd0AdditionalNamesScreen extends StatelessWidget {
  final List subcategories;
  final String title;

  const Icd0AdditionalNamesScreen(
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
          var item = subcategories[index];
          List icd10Codes = item["icd10-codes"] ?? [];
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subcategories[index]["code"] != null
                    ? Text(subcategories[index]["code"])
                    : const SizedBox.shrink(),
              ],
            ),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(subcategories[index]["name"]),
              const SizedBox(height: 10),
              ...icd10Codes.map((code) {
                return code != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(code['code']), Text(code['name'])]))
                    : const SizedBox.shrink();
              }).toList()
            ]),
            trailing: subcategories[index]["additional_names"] != null
                ? const Icon(Icons.arrow_forward_ios, size: 20)
                : const SizedBox.shrink(),
            onTap: () {
              if (subcategories[index]["additional_names"] != null) {
                context.pushNamed('icd_10_diseases_subcategories',
                    pathParameters: {
                      'title': subcategories[index]["name"],
                    },
                    extra: subcategories[index]["additional_names"]);
              }
            },
          );
        },
      ),
    );
  }
}
