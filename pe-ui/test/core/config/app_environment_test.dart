import 'package:flutter_test/flutter_test.dart';
import 'package:pe_ui/core/config/app_environment.dart';

void main() {
  test('parse maps names to environments', () {
    expect(AppEnvironment.parse('dev'), AppEnvironment.dev);
    expect(AppEnvironment.parse('stg'), AppEnvironment.stg);
    expect(AppEnvironment.parse('prod'), AppEnvironment.prod);
  });

  test('parse returns null for unknown or missing', () {
    expect(AppEnvironment.parse('qa'), isNull);
    expect(AppEnvironment.parse(null), isNull);
  });

  test('resolve falls back when ENV define absent', () {
    expect(AppEnvironment.resolve(AppEnvironment.stg), AppEnvironment.stg);
  });
}
