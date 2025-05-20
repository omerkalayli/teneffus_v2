import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:teneffus/app_router.dart';
import 'package:teneffus/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teneffus/firebase_options.dart';

final restartAppProvider = Provider<void Function()>(
  (ref) => throw UnimplementedError(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("tr_TR");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainAppWrapper());
}

class MainApp extends HookWidget {
  const MainApp({required this.router, super.key});

  final AppRouter router;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: router.config(),
    );
  }
}

class MainAppWrapper extends StatefulWidget {
  const MainAppWrapper({super.key});

  @override
  State<MainAppWrapper> createState() => _MainAppWrapperState();
}

class _MainAppWrapperState extends State<MainAppWrapper> {
  late Key _providerScopeKey;
  late AppRouter _router;
  @override
  void initState() {
    super.initState();
    _providerScopeKey = UniqueKey();
    _router = AppRouter();
  }

  void restartApp() {
    setState(() {
      _providerScopeKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      key: _providerScopeKey,
      overrides: [
        restartAppProvider.overrideWithValue(restartApp),
      ],
      child: MainApp(
        router: _router,
      ),
    );
  }
}
