import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:weather_app/core/configs/env_config.dart';
import 'package:weather_app/models/city.dart';
import 'package:http/http.dart' as http;

abstract class LocationServiceInterface {
  Future<List<CityModel>> searchCities(String keyword);
}

@LazySingleton(as: LocationServiceInterface)
class LocationRepositoryImpl implements LocationServiceInterface {
  @override
  Future<List<CityModel>> searchCities(String keyword) async {
    Uri url = Uri.parse(
      'http://api.openweathermap.org/geo/1.0/direct?q=$keyword&limit=5&appid=${EnvConfig.weatherApiKey}',
    );
    final response = await http.get(url);
    final List<Map<String, dynamic>> jsonList =
        List<Map<String, dynamic>>.from(jsonDecode(response.body));
    final List<CityModel> cities =
        jsonList.map((json) => CityModel.fromJson(json)).toList();
    return cities;
  }
}
