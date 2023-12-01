part of 'weather_cubit.dart';

@immutable
sealed class WeatherState extends Equatable {}

class WeatherInitial extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherFetching extends WeatherState {
  @override
  List<Object?> get props => [];
}


class WeatherFetchSuccessful extends WeatherState {
  final Weather weather;

  WeatherFetchSuccessful(this.weather);
  @override
  List<Object?> get props => [weather];
}

class WeatherFetchFailed extends WeatherState {
  final String message;

  WeatherFetchFailed(this.message);
  @override
  List<Object?> get props => [message];
}