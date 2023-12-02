import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final Location location;
  final Current current;
  final List<Forecast> forecasts;

  const Weather({
    required this.location,
    required this.current,
    required this.forecasts,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    List<Forecast> forecastDayList = List<Forecast>.from(
      json['forecast']['forecastday']
          .map((forecastDay) => Forecast.fromJson(forecastDay)),
    );

    return Weather(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecasts: forecastDayList,
    );
  }

  @override
  List<Object?> get props => [location, current, forecasts];
}

class Location extends Equatable {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final int localtimeEpoch;
  final String localtime;

  const Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      tzId: json['tz_id'],
      localtimeEpoch: json['localtime_epoch'],
      localtime: json['localtime'],
    );
  }

  @override
  List<Object?> get props =>
      [name, region, country, lat, lon, tzId, localtimeEpoch, localtime];
}

class Current extends Equatable {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final int isDay;
  final WeatherCondition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double visKm;
  final double visMiles;
  final double uv;
  final double gustMph;
  final double gustKph;

  const Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      lastUpdatedEpoch: json['last_updated_epoch'],
      lastUpdated: json['last_updated'],
      tempC: json['temp_c'].toDouble(),
      tempF: json['temp_f'].toDouble(),
      isDay: json['is_day'],
      condition: WeatherCondition.fromJson(json['condition']),
      windMph: json['wind_mph'].toDouble(),
      windKph: json['wind_kph'].toDouble(),
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressureMb: json['pressure_mb'].toDouble(),
      pressureIn: json['pressure_in'].toDouble(),
      precipMm: json['precip_mm'].toDouble(),
      precipIn: json['precip_in'].toDouble(),
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelslikeC: json['feelslike_c'].toDouble(),
      feelslikeF: json['feelslike_f'].toDouble(),
      visKm: json['vis_km'].toDouble(),
      visMiles: json['vis_miles'].toDouble(),
      uv: json['uv'],
      gustMph: json['gust_mph'].toDouble(),
      gustKph: json['gust_kph'].toDouble(),
    );
  }

  @override
  List<Object?> get props => [
        lastUpdatedEpoch,
        lastUpdated,
        tempC,
        tempF,
        isDay,
        condition,
        windMph,
        windKph,
        windDegree,
        windDir,
        pressureMb,
        pressureIn,
        precipMm,
        precipIn,
        humidity,
        cloud,
        feelslikeC,
        feelslikeF,
        visKm,
        visMiles,
        uv,
        gustMph,
        gustKph,
      ];
}

class WeatherCondition extends Equatable {
  final String text;
  final String icon;
  final int code;

  const WeatherCondition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    final icon = 'http:${json['icon']}';
    return WeatherCondition(
      text: json['text'],
      icon: icon,
      code: json['code'],
    );
  }

  @override
  List<Object?> get props => [text, icon, code];
}

class Forecast extends Equatable {
  final String date;
  final int dateEpoch;
  final Day day;
  final Astro astro;
  final List<HourForeCast> hoursForecast;

  const Forecast({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hoursForecast,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    List<HourForeCast> forecastHourList = List<HourForeCast>.from(
      json['hour']
          .map((forecastHour) => HourForeCast.fromJson(forecastHour)),
    );
    return Forecast(
      date: json['date'],
      dateEpoch: json['date_epoch'],
      day: Day.fromJson(json['day']),
      astro: Astro.fromJson(json['astro']),
      hoursForecast: forecastHourList,
    );
  }

  @override
  List<Object?> get props => [date, dateEpoch, day, astro];
}

class Astro extends Equatable {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final int moonIllumination;
  final int isMoonUp;
  final int isSunUp;

  const Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
    required this.isMoonUp,
    required this.isSunUp,
  });

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
      moonPhase: json['moon_phase'],
      moonIllumination: json['moon_illumination'],
      isMoonUp: json['is_moon_up'],
      isSunUp: json['is_sun_up'],
    );
  }

  @override
  List<Object?> get props => [
        sunrise,
        sunset,
        moonrise,
        moonset,
        moonPhase,
        moonIllumination,
        isMoonUp,
        isSunUp,
      ];
}

class Day extends Equatable {
  final double maxTempC;
  final double maxTempF;
  final double minTempC;
  final double minTempF;
  final double avgTempC;
  final double avgTempF;
  final double maxWindMph;
  final double maxWindKph;
  final double totalPrecipMm;
  final double totalPrecipIn;
  final double totalSnowCm;
  final double avgVisKm;
  final double avgVisMiles;
  final double avgHumidity;
  final int dailyWillItRain;
  final int dailyChanceOfRain;
  final int dailyWillItSnow;
  final int dailyChanceOfSnow;
  final WeatherCondition condition;
  final double uv;

  const Day({
    required this.maxTempC,
    required this.maxTempF,
    required this.minTempC,
    required this.minTempF,
    required this.avgTempC,
    required this.avgTempF,
    required this.maxWindMph,
    required this.maxWindKph,
    required this.totalPrecipMm,
    required this.totalPrecipIn,
    required this.totalSnowCm,
    required this.avgVisKm,
    required this.avgVisMiles,
    required this.avgHumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxTempC: json['maxtemp_c'].toDouble(),
      maxTempF: json['maxtemp_f'].toDouble(),
      minTempC: json['mintemp_c'].toDouble(),
      minTempF: json['mintemp_f'].toDouble(),
      avgTempC: json['avgtemp_c'].toDouble(),
      avgTempF: json['avgtemp_f'].toDouble(),
      maxWindMph: json['maxwind_mph'].toDouble(),
      maxWindKph: json['maxwind_kph'].toDouble(),
      totalPrecipMm: json['totalprecip_mm'].toDouble(),
      totalPrecipIn: json['totalprecip_in'].toDouble(),
      totalSnowCm: json['totalsnow_cm'].toDouble(),
      avgVisKm: json['avgvis_km'].toDouble(),
      avgVisMiles: json['avgvis_miles'].toDouble(),
      avgHumidity: json['avghumidity'],
      dailyWillItRain: json['daily_will_it_rain'],
      dailyChanceOfRain: json['daily_chance_of_rain'],
      dailyWillItSnow: json['daily_will_it_snow'],
      dailyChanceOfSnow: json['daily_chance_of_snow'],
      condition: WeatherCondition.fromJson(json['condition']),
      uv: json['uv'],
    );
  }

  @override
  List<Object?> get props => [
        maxTempC,
        maxTempF,
        minTempC,
        minTempF,
        avgTempC,
        avgTempF,
        maxWindMph,
        maxWindKph,
        totalPrecipMm,
        totalPrecipIn,
        totalSnowCm,
        avgVisKm,
        avgVisMiles,
        avgHumidity,
        dailyWillItRain,
        dailyChanceOfRain,
        dailyWillItSnow,
        dailyChanceOfSnow,
        condition,
        uv,
      ];
}

class HourForeCast extends Equatable {
  final int timeEpoch;
  final String time;
  final double tempC;
  final int isDay;
  final WeatherCondition condition;

  const HourForeCast({
    required this.timeEpoch,
    required this.time,
    required this.tempC,
    required this.isDay,
    required this.condition
  });

  factory HourForeCast.fromJson(Map<String, dynamic> json) {
    return HourForeCast(
      timeEpoch: json['time_epoch'],
      time: json['time'],
      tempC: json['temp_c'].toDouble(),
      isDay: json['is_day'],
      condition: WeatherCondition.fromJson(json['condition']),
    );
  }

  @override
  List<Object?> get props => [timeEpoch, time, tempC, isDay, condition];
}
