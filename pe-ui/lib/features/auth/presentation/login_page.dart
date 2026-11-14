import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pe_ui/core/design/responsive_body.dart';
import 'package:pe_ui/features/auth/presentation/auth_controller.dart';

/// Placeholder shell; Increment 2 delivers the final login UI.
class LoginPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    appBar: AppBar(title: const Text('Sign in')),
    body: ResponsiveBody(
      child: Center(
        child: FilledButton(
          onPressed: () => ref.read(authControllerProvider.notifier).signIn(),
          child: const Text('Continue with Google (demo)'),
        ),
      ),
    ),
  );
}
