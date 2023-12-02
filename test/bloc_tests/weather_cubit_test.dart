import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/configs/injectable_config.dart';
import 'package:weather_app/features/weather/blocs/weather_cubit/weather_cubit.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class MockWeatherRepository extends Mock
    implements WeatherRepositoryInterface {}

void main() {
  late WeatherCubit weatherCubit;
  late MockWeatherRepository mockWeatherRepository;
  mockWeatherRepository = MockWeatherRepository();
  getIt.registerLazySingleton<WeatherRepositoryInterface>(
      () => mockWeatherRepository);
  setUp(() {
    weatherCubit = WeatherCubit();
  });

  tearDown(() {
    weatherCubit.close();
  });

  group('WeatherCubit', () {
    const cityName = 'New York';
    const weather = Weather(
        current: Current(
          lastUpdatedEpoch: 0,
          lastUpdated: '',
          tempC: 0,
          tempF: 0,
          isDay: 1,
          condition: WeatherCondition(text: '', icon: '', code: 0),
          windMph: 0,
          windKph: 0,
          windDegree: 0,
          windDir: '',
          pressureMb: 0,
          pressureIn: 0,
          precipMm: 0,
          precipIn: 0,
          humidity: 0,
          cloud: 0,
          feelslikeC: 0,
          feelslikeF: 0,
          visKm: 0,
          visMiles: 0,
          uv: 0,
          gustMph: 0,
          gustKph: 0,
        ),
        location: Location(
          name: '',
          region: '',
          country: '',
          lat: 0,
          lon: 0,
          tzId: '',
          localtimeEpoch: 0,
          localtime: '',
        ),
        forecasts: []);

    blocTest<WeatherCubit, WeatherState>(
      'emits [WeatherFetching, WeatherFetchSuccessful] when getWeatherForLocation is called successfully',
      build: () {
        when(() => mockWeatherRepository.getWeather(cityName: cityName))
            .thenAnswer((_) async => weather);
        return weatherCubit;
      },
      act: (cubit) => cubit.getWeatherForLocation(cityName: cityName),
      expect: () => [
        WeatherFetching(),
        WeatherFetchSuccessful(weather),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits [WeatherFetching, WeatherFetchFailed] when an unexpected error occurs',
      build: () {
        when(() => mockWeatherRepository.getWeather(cityName: cityName))
            .thenThrow(Exception('Some error'));
        return weatherCubit;
      },
      act: (cubit) => cubit.getWeatherForLocation(cityName: cityName),
      expect: () => [
        WeatherFetching(),
        WeatherFetchFailed('Unexpected error happened, please try again.'),
      ],
    );
  });
}
