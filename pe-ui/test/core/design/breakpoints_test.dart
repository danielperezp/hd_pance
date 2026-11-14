import 'package:flutter_test/flutter_test.dart';
import 'package:pe_ui/core/design/breakpoints.dart';

void main() {
  test('of maps widths to layout sizes', () {
    expect(Breakpoints.of(599), LayoutSize.compact);
    expect(Breakpoints.of(600), LayoutSize.medium);
    expect(Breakpoints.of(1023), LayoutSize.medium);
    expect(Breakpoints.of(1024), LayoutSize.expanded);
  });
}
