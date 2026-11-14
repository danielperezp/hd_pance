import 'package:pe_ui/core/errors/failure.dart';
import 'package:pe_ui/features/auth/domain/session_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSessionStore implements SessionStore {
  new({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const String key = 'session.signed_in';

  final SharedPreferencesAsync _preferences;

  @override
  Future<bool> read() =>
      _guard(() async => await _preferences.getBool(key) ?? false, 'read');

  @override
  Future<void> write({required bool signedIn}) =>
      _guard(() => _preferences.setBool(key, signedIn), 'write');

  @override
  Future<void> clear() => _guard(() => _preferences.remove(key), 'clear');

  Future<T> _guard<T>(Future<T> Function() action, String op) async {
    try {
      return await action();
    } on Object catch (error) {
      throw StorageFailure('Session $op failed: $error');
    }
  }
}
