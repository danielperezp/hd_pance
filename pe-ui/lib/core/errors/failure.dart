/// Typed failures surfaced across layer boundaries.
sealed class Failure implements Exception {
  const new(this.message);

  final String message;

  @override
  String toString() => message;
}

final class StorageFailure extends Failure {
  const new(super.message);
}
