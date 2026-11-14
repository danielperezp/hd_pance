import 'package:flutter_test/flutter_test.dart';
import 'package:pe_ui/app/routes.dart';
import 'package:pe_ui/features/auth/domain/auth_status.dart';

void main() {
  group('authRedirect', () {
    test('signed out sends any route to login', () {
      expect(authRedirect(AuthStatus.signedOut, '/home'), '/login');
      expect(authRedirect(AuthStatus.signedOut, '/splash'), '/login');
    });

    test('signed out stays on login', () {
      expect(authRedirect(AuthStatus.signedOut, '/login'), isNull);
    });

    test('signed in sends login to home', () {
      expect(authRedirect(AuthStatus.signedIn, '/login'), '/home');
    });

    test('signed in stays on home', () {
      expect(authRedirect(AuthStatus.signedIn, '/home'), isNull);
    });

    test('loading holds on splash', () {
      expect(authRedirect(AuthStatus.loading, '/home'), '/splash');
      expect(authRedirect(AuthStatus.loading, '/splash'), isNull);
    });

    test('error routes to error page', () {
      expect(authRedirect(AuthStatus.error, '/home'), '/error');
      expect(authRedirect(AuthStatus.error, '/error'), isNull);
    });
  });
}
