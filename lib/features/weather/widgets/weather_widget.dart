import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/utils.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weather_icon.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildWeatherConditionAndHour(),
            buildWeatherIcon(screenWidth),
            const SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildCurrentWeather(),
                buildHourForecast(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Row buildWeatherConditionAndHour() {
    final date = Utils.parseDateTime(weather.location.localtime);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 100),
          child: Text(
            Utils.makeNewLineEveryWord(weather.current.condition.text),
            style: TextStyle(
                color: textColor(),
                fontSize: 30,
                height: 1.1,
                fontWeight: FontWeight.w500),
          ),
        ),
        const Spacer(),
        Text(
          DateFormat('HH:mm').format(
            date,
          ),
          style: TextStyle(
              color: textColor(),
              fontSize: 30,
              height: 1.1,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget buildWeatherIcon(double screenWidth) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        child: Lottie.asset(
            getWeatherLotties(
                weather.current.condition.text, weather.current.isDay == 1),
            fit: BoxFit.fitWidth,
            width: screenWidth * 0.9),
      ),
    );
  }

  Expanded buildCurrentWeather() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${weather.location.name}\n${weather.location.country}',
            style: TextStyle(
                color: textColor(), fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            '${weather.current.tempC.round()}°',
            style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.w300,
                height: 1.1,
                color: textColor()),
          ),
          Text(
            'feels like ${weather.current.feelslikeC.round()}°',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                height: 1.1,
                color: textColor()),
          ),
        ],
      ),
    );
  }

  Expanded buildHourForecast() {
    final currentHour = DateTime.parse(weather.current.lastUpdated).hour;
    final foreCastHour = weather.forecasts[0].hoursForecast;
    List<HourForeCast> twoNextHour = [];
    if (currentHour + 2 < foreCastHour.length) {
      twoNextHour.add(foreCastHour[currentHour + 2]);
    }
    if (currentHour + 4 < foreCastHour.length) {
      twoNextHour.add(foreCastHour[currentHour + 4]);
    }
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: twoNextHour
          .map((forecast) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('hh:mm').format(DateTime.parse(forecast.time)),
                      style: TextStyle(
                          color: textColor(),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Lottie.asset(
                        getWeatherLotties(
                            forecast.condition.text, forecast.isDay == 1),
                        width: 50,
                        fit: BoxFit.fitWidth),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${forecast.tempC.round()}°',
                      style: TextStyle(
                          color: textColor(),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ))
          .toList(),
    ));
  }

  Color textColor() =>
      weather.current.isDay == 1 ? const Color(0xff131B37) : Colors.white;
}
