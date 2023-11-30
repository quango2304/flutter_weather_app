part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  const LocationState();
}

class LocationInitial extends LocationState {
  @override
  List<Object> get props => [];
}

class LocationSearching extends LocationState {
  final List<CityModel> cities;

  const LocationSearching(this.cities);
  @override
  List<Object> get props => [cities];
}

class LocationSearchingFailed extends LocationState {
  final String message;
  const LocationSearchingFailed(this.message);
  @override
  List<Object> get props => [message];
}