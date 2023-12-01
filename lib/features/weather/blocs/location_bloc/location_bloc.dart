import 'dart:developer';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/configs/injectable_config.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/repositories/location_repository.dart';

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

  final LocationRepositoryInterface repo = getIt();

  void _onSearchLocation(SearchLocationEvent event, Emitter emitter) async {
    try {
      if(event.keyword.isEmpty) {
        emitter(LocationInitial());
      } else {
        final List<CityModel> cities = await repo.searchCities(event.keyword);
        emitter(LocationSearching(cities));
      }
    } catch (e, s) {
      log('_onSearchLocation $e $s');
      emitter(const LocationSearchingFailed(
          'Unexpected error happened, please try again.'));
    }
  }

  void _onSearchComplete(
      SearchLocationCompleteEvent event, Emitter emitter) async {
    emitter(LocationInitial());
  }
}
