import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator_config.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() => $initGetIt(getIt);
