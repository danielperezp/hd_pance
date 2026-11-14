import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pe_ui/core/design/responsive_body.dart';
import 'package:pe_ui/features/auth/presentation/auth_controller.dart';

/// Shown when session persistence fails; offers retry.
class SessionErrorPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    body: ResponsiveBody(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Could not access local storage.'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => ref.read(authControllerProvider.notifier).load(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    ),
  );
}
