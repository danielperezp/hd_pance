import 'package:pe_ui/app/bootstrap.dart';
import 'package:pe_ui/core/config/app_environment.dart';

void main() => bootstrap(AppEnvironment.resolve(AppEnvironment.prod));
