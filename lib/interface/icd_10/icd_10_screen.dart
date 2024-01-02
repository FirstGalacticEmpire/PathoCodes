import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patho_helper_mobile/widgets/basic_screen.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ICD10Screen extends StatefulWidget {
  const ICD10Screen({super.key});

  @override
  State<ICD10Screen> createState() => _ICD10ScreenState();
}

class _ICD10ScreenState extends State<ICD10Screen> {
  List _items = [];
  List _filteredItems = [];
  String searchTerm = '';

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/icd-10.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
      _filteredItems = List.from(_items);
    });
  }

  bool containsSearch(Map<String, dynamic> item, String searchTerm) {
    if (item['name']?.toLowerCase()?.contains(searchTerm.toLowerCase())) {
      return true;
    }
    if ((item['subcategories']?.length ?? 0) > 0) {
      return item['subcategories'].any((it) {
        return containsSearch(it, searchTerm);
      });
    }
    return false;
  }

  Map<String, dynamic> hasInteresting(
      Map<String, dynamic> item, String searchTerm) {
    if (item['name']?.toLowerCase()?.contains(searchTerm.toLowerCase())) {
      return item;
    }
    if ((item['subcategories']?.length ?? 0) == 0) {
      return {};
    }
    List<Map<String, dynamic>> newCategories =
        item['subcategories'].map<Map<String, dynamic>>((subc) {
      return hasInteresting(subc, searchTerm);
    }).toList() as List<Map<String, dynamic>>;

    List<Map<String, dynamic>> newCategories2 =
        newCategories.where((it) => it.containsKey("name")).toList();

    if (newCategories2.isEmpty) {
      return {};
    }

    Map<String, dynamic> newItem = {
      ...item,
      "subcategories": newCategories2,
    };
    return newItem;
  }

  List<dynamic> filterData(List data, String searchTerm) {
    return data.map((item) {
      return hasInteresting(item, searchTerm);
    }).where((it) {
      return it.containsKey("name");
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
      body: Column(children: [
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
              return ListTile(
                title: Text(_filteredItems[index]["code"]),
                subtitle: Text(_filteredItems[index]["name"]),
                trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () {
                  context.pushNamed('icd_10_subcategories',
                      pathParameters: {
                        'title': _filteredItems[index]["name"],
                      },
                      extra: _filteredItems[index]["subcategories"]);
                },
              );
            },
          ),
        ),
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
