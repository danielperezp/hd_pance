import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pe_ui/app/app.dart';
import 'package:pe_ui/core/config/app_environment.dart';
import 'package:pe_ui/features/auth/data/shared_preferences_session_store.dart';
import 'package:pe_ui/features/auth/presentation/auth_controller.dart';

void bootstrap(AppEnvironment environment) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: [
        appEnvironmentProvider.overrideWithValue(environment),
        sessionStoreProvider.overrideWithValue(SharedPreferencesSessionStore()),
      ],
      child: const App(),
    ),
  );
}
