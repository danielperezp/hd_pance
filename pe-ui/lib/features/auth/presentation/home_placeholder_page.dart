import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pe_ui/core/design/responsive_body.dart';
import 'package:pe_ui/features/auth/presentation/auth_controller.dart';

/// Placeholder signed-in destination; Increment 2 delivers the dashboard.
class HomePlaceholderPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    appBar: AppBar(
      title: const Text('Dashboard'),
      actions: [
        TextButton(
          onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
          child: const Text('Sign out'),
        ),
      ],
    ),
    body: const ResponsiveBody(child: Text('Signed in')),
  );
}
