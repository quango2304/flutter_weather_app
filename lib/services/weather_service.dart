import 'dart:convert';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:weather_app/core/configs/env_config.dart';
import 'package:weather_app/models/weather.dart';
import 'package:http/http.dart' as http;

abstract class WeatherServiceInterface {
  Future<Weather> getWeather({required String cityName});
}

@LazySingleton(as: WeatherServiceInterface)
class WeatherServiceIml implements WeatherServiceInterface {
  Uri _buildUri(Map<String, dynamic>? queryParameters) {
    Map<String, dynamic> query = {'key': EnvConfig.weatherApiKey};
    if (queryParameters != null) {
      query.addAll(queryParameters);
    }

    var uri = Uri(
      scheme: 'https',
      host: 'api.weatherapi.com',
      path: 'v1/forecast.json',
      queryParameters: query,
    );
    return uri;
  }

  @override
  Future<Weather> getWeather({required String cityName}) async {
    final uri = _buildUri({'q': cityName, 'days': 5.toString()});
    log(uri.toString());
    final res = await http.get(uri);
    final weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }
}
