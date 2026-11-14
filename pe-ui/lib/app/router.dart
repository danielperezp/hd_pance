import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pe_ui/app/routes.dart';
import 'package:pe_ui/features/auth/presentation/auth_controller.dart';
import 'package:pe_ui/features/auth/presentation/home_placeholder_page.dart';
import 'package:pe_ui/features/auth/presentation/login_page.dart';
import 'package:pe_ui/features/auth/presentation/session_error_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref
    ..listen(authControllerProvider, (_, _) => refresh.value++)
    ..onDispose(refresh.dispose);

  final router = GoRouter(
    initialLocation: AppRoute.splash.path,
    refreshListenable: refresh,
    redirect: (context, state) =>
        authRedirect(ref.read(authControllerProvider), state.matchedLocation),
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        builder: (_, _) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(path: AppRoute.login.path, builder: (_, _) => const LoginPage()),
      GoRoute(
        path: AppRoute.home.path,
        builder: (_, _) => const HomePlaceholderPage(),
      ),
      GoRoute(
        path: AppRoute.error.path,
        builder: (_, _) => const SessionErrorPage(),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
