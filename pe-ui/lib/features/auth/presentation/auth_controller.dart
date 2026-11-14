import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pe_ui/features/auth/domain/auth_status.dart';
import 'package:pe_ui/features/auth/domain/session_store.dart';

/// Overridden at the app root with a concrete store.
final sessionStoreProvider = Provider<SessionStore>(
  (ref) => throw UnimplementedError('sessionStoreProvider must be overridden'),
);

final authControllerProvider = NotifierProvider<AuthController, AuthStatus>(
  AuthController.new,
);

class AuthController extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    unawaited(Future.microtask(load));
    return AuthStatus.loading;
  }

  SessionStore get _store => ref.read(sessionStoreProvider);

  /// Reads the stored session. Persistence failure never reports signed in.
  Future<void> load() async {
    state = AuthStatus.loading;
    try {
      final signedIn = await _store.read();
      state = signedIn ? AuthStatus.signedIn : AuthStatus.signedOut;
    } on Object {
      state = AuthStatus.error;
    }
  }

  Future<void> signIn() async {
    try {
      await _store.write(signedIn: true);
      state = AuthStatus.signedIn;
    } on Object {
      state = AuthStatus.error;
    }
  }

  Future<void> signOut() async {
    try {
      await _store.clear();
      state = AuthStatus.signedOut;
    } on Object {
      state = AuthStatus.error;
    }
  }
}
