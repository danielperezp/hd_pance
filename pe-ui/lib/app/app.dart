import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pe_ui/app/router.dart';
import 'package:pe_ui/core/config/app_environment.dart';
import 'package:pe_ui/core/design/app_theme.dart';

final appEnvironmentProvider = Provider<AppEnvironment>(
  (ref) =>
      throw UnimplementedError('appEnvironmentProvider must be overridden'),
);

class App extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final env = ref.watch(appEnvironmentProvider);
    return MaterialApp.router(
      title: env.appName,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
