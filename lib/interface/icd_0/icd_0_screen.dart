import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patho_helper_mobile/widgets/basic_screen.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ICD0Screen extends StatefulWidget {
  const ICD0Screen({super.key});

  @override
  State<ICD0Screen> createState() => _ICD0ScreenState();
}

class _ICD0ScreenState extends State<ICD0Screen> {
  List _items = [];
  List _filteredItems = [];
  String searchTerm = '';

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/icd0_codes.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
      _filteredItems = List.from(_items);
    });
  }

  Map<String, dynamic> hasInteresting(
      Map<String, dynamic> item, String searchTerm) {
    String lowerSearchTerm = searchTerm.toLowerCase();

    if (item['name']?.toLowerCase()?.contains(lowerSearchTerm) ?? false) {
      return item;
    }

    if (item['icd10-codes'] != null && item['icd10-codes'] is List) {
      for (var code in item['icd10-codes']) {
        if (code is Map<String, dynamic> && code.containsKey('name')) {
          String name = code['name'];
          if (name.toLowerCase().contains(lowerSearchTerm)) {
            return item;
          }
        }
      }
    }

    if (item['additional_names']?.isNotEmpty ?? false) {
      List<Map<String, dynamic>> newCategories = [];

      for (var subc in item['additional_names']) {
        var result = hasInteresting(subc, searchTerm);
        if (result.isNotEmpty) {
          newCategories.add(result);
        }
      }

      if (newCategories.isNotEmpty) {
        return {
          ...item,
          "additional_names": newCategories,
        };
      }
    }
    return {};
  }

  List<dynamic> filterData(List data, String searchTerm) {
    return data.map((item) {
      return hasInteresting(item, searchTerm);
    }).where((it) {
      return it.isNotEmpty;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    _filteredItems = filterData(_items, searchTerm);
    return BasicScreen(
      backgroundColor: Colors.white,
      appContext: context,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchTerm = value;
              });
            },
            decoration: const InputDecoration(
              labelText: "Wyszukaj",
              hintText: "Wprowadź nazwę choroby",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              var item = _filteredItems[index];
              List icd10Codes = item["icd10-codes"] ?? [];
              return ListTile(
                title: Text(_filteredItems[index]["code"]),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_filteredItems[index]["name"]),
                      const SizedBox(height: 10),
                      ...icd10Codes.map((code) {
                        return code != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(code['code']),
                                      Text(code['name'])
                                    ]))
                            : const SizedBox.shrink();
                      }).toList(),
                      const Divider(
                        height: 20,
                        thickness: 0.5,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ]),
                trailing: _filteredItems[index]["additional_names"].isNotEmpty
                    ? const Icon(Icons.arrow_forward_ios, size: 20)
                    : const SizedBox.shrink(),
                onTap: () {
                  if (_filteredItems[index]["additional_names"].isNotEmpty) {
                    context.pushNamed('icd_0_additional_names',
                        pathParameters: {
                          'title': _filteredItems[index]["name"],
                        },
                        extra: _filteredItems[index]["additional_names"]);
                  }
                },
              );
            },
          ),
        ),
      ]),
      title: 'ICD-0',
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
