import 'package:injectable/injectable.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/services/location_service.dart';

abstract class LocationRepositoryInterface {
  Future<List<CityModel>> searchCities(String keyword);
}

@LazySingleton(as: LocationRepositoryInterface)
class LocationRepositoryImpl implements LocationRepositoryInterface {
  final LocationServiceInterface service;

  LocationRepositoryImpl(this.service);

  @override
  Future<List<CityModel>> searchCities(String keyword) {
    return service.searchCities(keyword);
  }
}
