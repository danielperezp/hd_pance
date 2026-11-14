import 'package:flutter/material.dart';
import 'package:pe_ui/core/design/breakpoints.dart';
import 'package:pe_ui/core/design/spacing.dart';

/// Centers content with a max width and size-aware padding.
class ResponsiveBody extends StatelessWidget {
  const new({required this.child, super.key});

  final Widget child;

  static const double _maxContentWidth = 720;

  @override
  Widget build(BuildContext context) {
    final size = Breakpoints.fromContext(context);
    final padding = switch (size) {
      LayoutSize.compact => Spacing.md,
      LayoutSize.medium => Spacing.lg,
      LayoutSize.expanded => Spacing.xl,
    };
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxContentWidth),
        child: Padding(padding: EdgeInsets.all(padding), child: child),
      ),
    );
  }
}
