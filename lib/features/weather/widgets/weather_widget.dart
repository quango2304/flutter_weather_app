import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/widgets/current_weather.dart';
import 'package:weather_app/features/weather/widgets/forecast_widget.dart';
import 'package:weather_app/features/weather/widgets/value_tile.dart';
import 'package:weather_app/models/weather.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  WeatherWidget({required this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Text(
            weather.location.name?? '',
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 5,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 20),
          Text(
            weather.location.country,
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 5,
              fontWeight: FontWeight.w100,
            ),
          ),
          CurrentConditions(weather: weather),
          Padding(
            child: Divider(
            ),
            padding: EdgeInsets.all(10),
          ),
          ForecastHorizontal(forecastDay: weather.forecast.forecastDay),
          Padding(
            child: Divider(
            ),
            padding: EdgeInsets.all(10),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ValueTile("wind speed", '${this.weather.current.windKph} km/h'),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                    width: 1,
                    height: 30,

                  )),
            ),
            ValueTile(
                "sunrise",
                weather.forecast.forecastDay[0].astro.sunrise),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                    width: 1,
                    height: 30,

                  )),
            ),
            ValueTile(
                "sunset",
                weather.forecast.forecastDay[0].astro.sunset),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                    width: 1,
                    height: 30,

                  )),
            ),
            ValueTile("humidity", '${this.weather.current.humidity}%'),
          ]),
        ],
      ),
    );
  }
}
