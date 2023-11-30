import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String country;

  const CityModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      country: json['country'] as String,
    );
  }

  @override
  List<Object?> get props => [name, lat, lon, country];
}