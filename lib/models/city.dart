import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String country;
  final String region;

  const CityModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.region,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
        name: json['name'] ?? '',
        lat: json['lat'] ?? 0.0,
        lon: json['lon'] ?? 0.0,
        country: json['country'] ?? '',
        region: json['region'] ?? '');
  }

  @override
  List<Object?> get props => [name, lat, lon, country, region];
}
