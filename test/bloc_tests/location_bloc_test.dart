import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/configs/injectable_config.dart';
import 'package:weather_app/features/weather/blocs/location_bloc/location_bloc.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/repositories/location_repository.dart';

class MockLocationRepository extends Mock
    implements LocationRepositoryInterface {}

void main() {
  late LocationBloc locationBloc;
  late MockLocationRepository mockLocationRepository;
  mockLocationRepository = MockLocationRepository();
  getIt.registerLazySingleton<LocationRepositoryInterface>(
          () => mockLocationRepository);
  setUp(() {
    locationBloc = LocationBloc();
  });
  tearDown(() {
    locationBloc.close();
  });

  group('LocationBloc', () {
    const keyword = 'New York';
    final cities = [
      const CityModel(name: keyword,
          region: '',
          country: 'US',
          lon: 0,
          lat: 0)
    ];

    blocTest<LocationBloc, LocationState>(
        'emits [LocationInitial, LocationSearching, LocationSearchingFailed] when SearchLocationEvent is added',
        build: () {
          when(() => mockLocationRepository.searchCities(keyword))
              .thenAnswer((_) async => cities);
          return locationBloc;
        },
        act: (bloc) => bloc.add(const SearchLocationEvent(keyword)),
        expect: () =>
        [
          LocationSearching(cities),
        ],
        wait: const Duration(seconds: 1));

    blocTest<LocationBloc, LocationState>(
      'emits [LocationInitial] when SearchLocationCompleteEvent is added',
      build: () => locationBloc,
      act: (bloc) => bloc.add(const SearchLocationCompleteEvent()),
      expect: () => [LocationInitial()],
    );

    blocTest<LocationBloc, LocationState>(
        'emits [LocationInitial] when SearchLocationEvent with an empty keyword is added',
        build: () => locationBloc,
        act: (bloc) => bloc.add(const SearchLocationEvent('')),
        expect: () => [LocationInitial()],
        wait: const Duration(seconds: 1));

    blocTest<LocationBloc, LocationState>(
        'emits [LocationSearchingFailed] when an unexpected error occurs',
        build: () {
          when(() => mockLocationRepository.searchCities(any()))
              .thenThrow(Exception('Some error'));
          return locationBloc;
        },
        act: (bloc) => bloc.add(const SearchLocationEvent(keyword)),
        expect: () =>
        [
          const LocationSearchingFailed(
              'Unexpected error happened, please try again.')
        ],
        wait: const Duration(seconds: 1)
    );
  });
}
