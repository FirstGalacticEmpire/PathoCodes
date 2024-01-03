import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:patho_helper_mobile/providers/router_provider.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  }, (error, stackTrace) {});
}
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Patho helper',
      builder: (context, child) {
        return child ?? Container();
      },
      routerConfig: router,
    );
  }
}
