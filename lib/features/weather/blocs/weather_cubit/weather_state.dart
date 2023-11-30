part of 'weather_cubit.dart';

@immutable
abstract class WeatherState extends Equatable {}

class WeatherInitial extends WeatherState {
  @override
  List<Object?> get props => [];
}
