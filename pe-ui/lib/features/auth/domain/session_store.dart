/// Persists the local demo signed-in flag.
///
/// Implementations throw `StorageFailure` when the backing store fails.
abstract interface class SessionStore {
  Future<bool> read();

  Future<void> write({required bool signedIn});

  Future<void> clear();
}
