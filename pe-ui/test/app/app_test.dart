import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pe_ui/app/app.dart';
import 'package:pe_ui/core/config/app_environment.dart';
import 'package:pe_ui/core/errors/failure.dart';
import 'package:pe_ui/features/auth/domain/session_store.dart';
import 'package:pe_ui/features/auth/presentation/auth_controller.dart';

class _MockSessionStore extends Mock implements SessionStore;

void main() {
  late _MockSessionStore store;

  setUp(() => store = _MockSessionStore());

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appEnvironmentProvider.overrideWithValue(AppEnvironment.dev),
          sessionStoreProvider.overrideWithValue(store),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('no stored session shows login', (tester) async {
    when(() => store.read()).thenAnswer((_) async => false);
    await pumpApp(tester);
    expect(find.text('Continue with Google (demo)'), findsOneWidget);
  });

  testWidgets('stored session shows home', (tester) async {
    when(() => store.read()).thenAnswer((_) async => true);
    await pumpApp(tester);
    expect(find.text('Signed in'), findsOneWidget);
  });

  testWidgets('sign in then sign out round trip', (tester) async {
    when(() => store.read()).thenAnswer((_) async => false);
    when(() => store.write(signedIn: true)).thenAnswer((_) async {});
    when(() => store.clear()).thenAnswer((_) async {});
    await pumpApp(tester);

    await tester.tap(find.text('Continue with Google (demo)'));
    await tester.pumpAndSettle();
    expect(find.text('Signed in'), findsOneWidget);

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();
    expect(find.text('Continue with Google (demo)'), findsOneWidget);
    verify(() => store.clear()).called(1);
  });

  testWidgets('read failure shows error and retry recovers', (tester) async {
    when(() => store.read()).thenThrow(const StorageFailure('boom'));
    await pumpApp(tester);
    expect(find.text('Retry'), findsOneWidget);
    expect(find.text('Signed in'), findsNothing);

    when(() => store.read()).thenAnswer((_) async => false);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Continue with Google (demo)'), findsOneWidget);
  });
}
