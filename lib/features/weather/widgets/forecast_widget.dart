import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/widgets/value_tile.dart';
import 'package:weather_app/models/weather.dart';

/// Renders a horizontal scrolling list of weather conditions
/// Used to show forecast
/// Shows DateTime, Weather Condition icon and Temperature
class ForecastHorizontal extends StatelessWidget {
  const ForecastHorizontal({
    Key? key,
    required this.forecastDay,
  }) : super(key: key);

  final List<ForecastDay> forecastDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: this.forecastDay.length,
        separatorBuilder: (context, index) => Divider(
          height: 100,
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (context, index) {
          final item = this.forecastDay[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
                child: ValueTile(
                  '${item.day.condition.text}',
                  '${item.day.avgTempC.round()}°',
                  iconUrl: item.day.condition.icon,
                )),
          );
        },
      ),
    );
  }
}
