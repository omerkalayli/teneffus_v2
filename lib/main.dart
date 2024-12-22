import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/app_router.dart';
import 'package:teneffus/app_theme.dart';

void main() {
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends HookWidget {
  MainApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: _appRouter.config(),
    );
  }
}
