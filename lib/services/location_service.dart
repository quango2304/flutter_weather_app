import 'dart:convert';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:weather_app/core/configs/env_config.dart';
import 'package:weather_app/models/city.dart';
import 'package:http/http.dart' as http;

abstract class LocationServiceInterface {
  Future<List<CityModel>> searchCities(String keyword);
}

@LazySingleton(as: LocationServiceInterface)
class LocationRepositoryImpl implements LocationServiceInterface {
  Uri _buildUri(Map<String, dynamic>? queryParameters) {
    Map<String, dynamic> query = {'key': EnvConfig.weatherApiKey};
    if (queryParameters != null) {
      query.addAll(queryParameters);
    }

    var uri = Uri(
      scheme: 'https',
      host: 'api.weatherapi.com',
      path: 'v1/search.json',
      queryParameters: query,
    );
    return uri;
  }

  @override
  Future<List<CityModel>> searchCities(String keyword) async {
    final uri = _buildUri({'q': keyword});
    log(uri.toString());
    final response = await http.get(uri);
    final List<Map<String, dynamic>> jsonList =
        List<Map<String, dynamic>>.from(jsonDecode(response.body));
    final List<CityModel> cities =
        jsonList.map((json) => CityModel.fromJson(json)).toList();
    return cities;
  }
}
