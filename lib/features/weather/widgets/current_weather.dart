import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/widgets/value_tile.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weather_icon.dart';

/// Renders Weather Icon, current, min and max temperatures
class CurrentConditions extends StatelessWidget {
  final Weather weather;

  const CurrentConditions({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentTemp = weather.current.tempC.round();
    int feelsLikeTemp = weather.current.feelslikeC.round();
    print("weather.current. ${weather.current.condition.code}");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          weather.current.condition.text,
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.w100),
        ),
        Icon(
          WeatherIcon.fromName(weather.current.condition.text),
          size: 150,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '$currentTemp°',
          style: TextStyle(fontSize: 100, fontWeight: FontWeight.w100),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile("feel like", '$feelsLikeTemp'),
        ]),
      ],
    );
  }
}
