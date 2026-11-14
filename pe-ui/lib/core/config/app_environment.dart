/// Deployment environments selectable through `--dart-define=ENV=<name>`.
enum AppEnvironment {
  dev('Pance Dev'),
  stg('Pance Stg'),
  prod('Pance');

  new(this.appName);

  final String appName;

  static const String _defined = String.fromEnvironment('ENV');

  /// Returns the environment from `--dart-define=ENV`, or [fallback] when
  /// the define is absent or unknown.
  static AppEnvironment resolve(AppEnvironment fallback) =>
      parse(_defined) ?? fallback;

  static AppEnvironment? parse(String? value) {
    for (final env in values) {
      if (env.name == value) return env;
    }
    return null;
  }
}
