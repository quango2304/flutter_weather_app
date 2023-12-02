// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:weather_app/repositories/location_repository.dart' as _i5;
import 'package:weather_app/repositories/weather_repository.dart' as _i6;
import 'package:weather_app/services/location_service.dart' as _i3;
import 'package:weather_app/services/weather_service.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.LocationServiceInterface>(
        () => _i3.LocationRepositoryImpl());
    gh.lazySingleton<_i4.WeatherServiceInterface>(
        () => _i4.WeatherServiceIml());
    gh.lazySingleton<_i5.LocationRepositoryInterface>(
        () => _i5.LocationRepositoryImpl(gh<_i3.LocationServiceInterface>()));
    gh.lazySingleton<_i6.WeatherRepositoryInterface>(
        () => _i6.WeatherRepositoryImpl(gh<_i4.WeatherServiceInterface>()));
    return this;
  }
}
