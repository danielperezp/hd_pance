import 'package:flutter/widgets.dart';

enum LayoutSize { compact, medium, expanded }

abstract final class Breakpoints {
  static const double medium = 600;
  static const double expanded = 1024;

  static LayoutSize of(double width) {
    if (width < medium) return LayoutSize.compact;
    if (width < expanded) return LayoutSize.medium;
    return LayoutSize.expanded;
  }

  static LayoutSize fromContext(BuildContext context) =>
      of(MediaQuery.sizeOf(context).width);
}
