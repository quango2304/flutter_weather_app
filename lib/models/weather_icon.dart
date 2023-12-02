import 'package:weather_app/core/asset_path.dart';

String getWeatherLotties(String weatherCondition, bool isDay) {
  final lowerCase = weatherCondition.toLowerCase();
  if(isDay) {
    if (lowerCase.contains('cloud')) {
      return AssetPath.dayCloudyLotties.path;
    } else if (lowerCase.contains('rain')) {
      return AssetPath.dayRainLotties.path;
    } else if (lowerCase.contains('sun')) {
      return AssetPath.daySunnyLotties.path;
    } else if (lowerCase.contains('mist') || lowerCase.contains('fog')) {
      return AssetPath.dayFogLotties.path;
    } else if (lowerCase.contains('thunder')) {
      return AssetPath.thunderRainLotties.path;
    } else if (lowerCase.contains('free') || lowerCase.contains('ice')) {
      return AssetPath.dayIceLotties.path;
    } else {
      return AssetPath.dayCloudyLotties.path;
    }
  } else {
    if (lowerCase.contains('cloud')) {
      return AssetPath.nightCloudyLotties.path;
    } else if (lowerCase.contains('rain')) {
      return AssetPath.nightRainLotties.path;
    } else if (lowerCase.contains('clear')) {
      return AssetPath.nightClearLotties.path;
    } else if (lowerCase.contains('mist') || lowerCase.contains('fog')) {
      return AssetPath.nightFogLotties.path;
    } else if (lowerCase.contains('thunder')) {
      return AssetPath.thunderRainLotties.path;
    } else if (lowerCase.contains('free') || lowerCase.contains('ice')) {
      return AssetPath.nightIceLotties.path;
    } else {
      return AssetPath.nightCloudyLotties.path;
    }
  }
}