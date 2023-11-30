import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/configs/injectable_config.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: false,
)
void configureDependencies() => getIt.init();