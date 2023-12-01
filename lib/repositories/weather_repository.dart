import 'package:injectable/injectable.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_service.dart';

abstract class WeatherRepositoryInterface {
  Future<Weather> getWeather({required String cityName});
}

@LazySingleton(as: WeatherRepositoryInterface)
class WeatherRepositoryImpl implements WeatherRepositoryInterface {
  final WeatherServiceInterface service;

  WeatherRepositoryImpl(this.service);
  @override
  Future<Weather> getWeather({required String cityName}) async {
    var weather = await service.getWeather(cityName: cityName);
    return weather;
  }
}