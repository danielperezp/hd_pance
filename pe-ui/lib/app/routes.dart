import 'package:pe_ui/features/auth/domain/auth_status.dart';

enum AppRoute {
  splash('/splash'),
  login('/login'),
  home('/home'),
  error('/error');

  new(this.path);

  final String path;
}

/// Returns the redirect target for [location], or null to stay.
String? authRedirect(AuthStatus status, String location) {
  final target = switch (status) {
    AuthStatus.loading => AppRoute.splash,
    AuthStatus.error => AppRoute.error,
    AuthStatus.signedOut => AppRoute.login,
    AuthStatus.signedIn => AppRoute.home,
  };
  return location == target.path ? null : target.path;
}
