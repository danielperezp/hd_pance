import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pe_ui/core/errors/failure.dart';
import 'package:pe_ui/features/auth/data/shared_preferences_session_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  late SharedPreferencesSessionStore store;

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    store = SharedPreferencesSessionStore();
  });

  test('read returns false when nothing stored', () async {
    expect(await store.read(), isFalse);
  });

  test('write then read returns stored value', () async {
    await store.write(signedIn: true);
    expect(await store.read(), isTrue);
  });

  test('clear removes session', () async {
    await store.write(signedIn: true);
    await store.clear();
    expect(await store.read(), isFalse);
  });

  group('failure', () {
    late _MockPreferences prefs;

    setUp(() {
      prefs = _MockPreferences();
      store = SharedPreferencesSessionStore(preferences: prefs);
    });

    test('read throws StorageFailure', () {
      when(() => prefs.getBool(any())).thenThrow(Exception('boom'));
      expect(store.read(), throwsA(isA<StorageFailure>()));
    });

    test('write throws StorageFailure', () {
      when(() => prefs.setBool(any(), any())).thenThrow(Exception('boom'));
      expect(store.write(signedIn: true), throwsA(isA<StorageFailure>()));
    });

    test('clear throws StorageFailure', () {
      when(() => prefs.remove(any())).thenThrow(Exception('boom'));
      expect(store.clear(), throwsA(isA<StorageFailure>()));
    });
  });
}

class _MockPreferences extends Mock implements SharedPreferencesAsync;
