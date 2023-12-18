import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const home = '/home';
  static build(String route, List<String> params) =>
      [route, ...params].join('/');
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        name: 'home',
        path: '${Routes.home}/:tab',
        builder: (BuildContext context, GoRouterState state) => MainScreen(
          key: state.pageKey,
          currentTab: int.tryParse(state.pathParameters['tab'] ?? '') ?? 0,
        ),
      ),
    ],
  );
});

GoRoute buildRoute(String path, Widget screen) => GoRoute(
      path: path,
      builder: (BuildContext context, GoRouterState state) => screen,
    );
