import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/core/configs/injectable_config.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());
  final WeatherRepositoryInterface repo = getIt();

  void getWeatherForLocation({required String cityName}) async {
    try {
      emit(WeatherFetching());
      final weather = await repo.getWeather(cityName: cityName);
      emit(WeatherFetchSuccessful(weather));
    } catch(e,s) {
      log("$e $s");
      emit(WeatherFetchFailed('Unexpected error happened, please try again.'));
    }
  }
}
