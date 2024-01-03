import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:patho_helper_mobile/interface/home_screen.dart';
import 'package:patho_helper_mobile/interface/icd_0/icd_0_additional_names_screen.dart';
import 'package:patho_helper_mobile/interface/icd_10/icd_10_diseases.dart';
import 'package:patho_helper_mobile/interface/icd_10/icd_10_diseases_subcategories.dart';
import 'package:patho_helper_mobile/interface/icd_10/icd_10_subcategories_screen.dart';

class Routes {
  static const home = '/home';
  static const icd10Subcategories = '/icd_10_subcategories';
  static const icd10Diseases = '/icd_10_diseases';
  static const icd10DiseasesSubcategories = '/icd_10_diseases_subcategories';
  static const icd0AdditionalNames = '/icd_0_additionalNames';

  static build(String route, List<String> params) =>
      [route, ...params].join('/');
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home/${0}',
    routes: [
      GoRoute(
        name: 'home',
        path: '${Routes.home}/:tab',
        builder: (BuildContext context, GoRouterState state) => HomeScreen(
          key: state.pageKey,
          currentTab: int.tryParse(state.pathParameters['tab'] ?? '') ?? 0,
        ),
      ),
      GoRoute(
        name: 'icd_10_subcategories',
        path: '${Routes.icd10Subcategories}/:title',
        builder: (BuildContext context, GoRouterState state) =>
            Icd10SubcategoriesScreen(
          subcategories: state.extra! as List<dynamic>,
          title: state.pathParameters['title'] ?? '',
        ),
      ),
      GoRoute(
        name: 'icd_10_diseases',
        path: '${Routes.icd10Diseases}/:title',
        builder: (BuildContext context, GoRouterState state) =>
            Icd10DiseasesScreen(
          subcategories: state.extra! as List<dynamic>,
          title: state.pathParameters['title'] ?? '',
        ),
      ),
      GoRoute(
        name: 'icd_10_diseases_subcategories',
        path: '${Routes.icd10DiseasesSubcategories}/:title',
        builder: (BuildContext context, GoRouterState state) =>
            Icd10DiseasesSubcategoriesScreen(
          subcategories: state.extra! as List<dynamic>,
          title: state.pathParameters['title'] ?? '',
        ),
      ),
      GoRoute(
        name: 'icd_0_additional_names',
        path: '${Routes.icd0AdditionalNames}/:title',
        builder: (BuildContext context, GoRouterState state) =>
            Icd0AdditionalNamesScreen(
          subcategories: state.extra! as List<dynamic>,
          title: state.pathParameters['title'] ?? '',
        ),
      ),
    ],
  );
});

GoRoute buildRoute(String path, Widget screen) => GoRoute(
      path: path,
      builder: (BuildContext context, GoRouterState state) => screen,
    );
