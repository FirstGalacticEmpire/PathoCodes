import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:go_router/go_router.dart';
import 'package:patho_helper_mobile/interface/favorites_screen.dart';
import 'package:patho_helper_mobile/interface/icd_10_screen.dart';
import 'package:patho_helper_mobile/interface/idc_o_screen.dart';
import 'package:patho_helper_mobile/interface/stains_screen.dart';
import 'package:patho_helper_mobile/widgets/custom_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({required this.currentTab, super.key});
  final int currentTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pages = <Widget>[
      const ICD10Screen(),
      const ICDOScreen(),
      const FavoritesScreen(),
      const StainsScreen(),
    ];

    final items = [
      const BottomNavigationBarItem(
        icon: Icon(Ionicons.medical),
        activeIcon: Icon(Ionicons.medical),
        label: 'ICD-10',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Ionicons.medical),
        activeIcon: Icon(Ionicons.medical),
        label: 'ICD-O',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Ionicons.heart),
        activeIcon: Icon(Ionicons.heart),
        label: 'Favorites',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Ionicons.color_fill),
        activeIcon: Icon(Ionicons.color_fill),
        label: 'Stains',
      ),
    ];

    return Scaffold(
      drawer: const CustomDrawer(),
      body: IndexedStack(index: currentTab, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        backgroundColor: Theme.of(context).colorScheme.background,
        unselectedLabelStyle: const TextStyle(
          fontSize: 14.0,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 14.0,
        ),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (int index) {
          context.goNamed(
            'home',
            pathParameters: {
              'tab': '$index',
            },
          );
        },
        items: items,
      ),
    );
  }
}
