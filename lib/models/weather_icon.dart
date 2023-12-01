import 'package:flutter/material.dart';

class WeatherIcon extends IconData {
  const WeatherIcon._(int codePoint)
      : super(
          codePoint,
          fontFamily: 'WeatherIcons',
        );

  factory WeatherIcon.fromName(String name) {
    if (name.contains('cloud')) {
      return const WeatherIcon._(0xf041);
    } else if (name.contains('rain')) {
      return const WeatherIcon._(0xf019);
    } else if (name.contains('sun')) {
      return const WeatherIcon._(0xf00d);
    } else if (name.contains('clear')) {
      return const WeatherIcon._(0xf041);
    } else if (name.contains('mist') || name.contains('fog')) {
      return const WeatherIcon._(0xf014);
    } else if (name.contains('thunder')) {
      return const WeatherIcon._(0xf01e);
    } else if (name.contains('free') || name.contains('ice')) {
      return const WeatherIcon._(0xf038);
    }
    return const WeatherIcon._(0xf041);
  }
}
