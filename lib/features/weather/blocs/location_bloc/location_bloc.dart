import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/configs/env_config.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/city.dart';

part 'location_event.dart';

part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<SearchLocationEvent>(_onSearchLocation,
        transformer: (events, mapper) => events
            .debounce(const Duration(milliseconds: 300))
            .switchMap(mapper));
    on<SearchLocationCompleteEvent>(_onSearchComplete);
  }

  void _onSearchLocation(SearchLocationEvent event, Emitter emitter) async {
    Uri url = Uri.parse(
      'http://api.openweathermap.org/geo/1.0/direct?q=${event.keyword}&limit=5&appid=${EnvConfig.weatherApiKey}',
    );
    try {
      final response = await http.get(url);
      final List<Map<String, dynamic>> jsonList =
          List<Map<String, dynamic>>.from(jsonDecode(response.body));
      final List<CityModel> cities =
          jsonList.map((json) => CityModel.fromJson(json)).toList();
      emitter(LocationSearching(cities));
    } catch (error) {
      log('_onSearchLocation $error');
      emitter(const LocationSearchingFailed(
          'Unexpected error happened, please try again.'));
    }
  }

  void _onSearchComplete(
      SearchLocationCompleteEvent event, Emitter emitter) async {
    emitter(LocationInitial());
  }
}
