part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();
}

class SearchLocationEvent extends LocationEvent {
  final String keyword;

  const SearchLocationEvent(this.keyword);
  @override
  List<Object?> get props => [keyword];
}

class SearchLocationCompleteEvent extends LocationEvent {
  const SearchLocationCompleteEvent();
  @override
  List<Object?> get props => [];
}