import 'package:weather_app/core/asset_path.dart';

String getWeatherLottie(String weatherCondition, bool isDay) {
  final lowerCase = weatherCondition.toLowerCase();
  if(isDay) {
    if (lowerCase.contains('cloud')) {
      return AssetPath.dayCloudyLottie.path;
    } else if (lowerCase.contains('rain')) {
      return AssetPath.dayRainLottie.path;
    } else if (lowerCase.contains('sun')) {
      return AssetPath.daySunnyLottie.path;
    } else if (lowerCase.contains('mist') || lowerCase.contains('fog')) {
      return AssetPath.dayFogLottie.path;
    } else if (lowerCase.contains('thunder')) {
      return AssetPath.thunderRainLottie.path;
    } else if (lowerCase.contains('free') || lowerCase.contains('ice')) {
      return AssetPath.dayIceLottie.path;
    } else {
      return AssetPath.dayCloudyLottie.path;
    }
  } else {
    if (lowerCase.contains('cloud')) {
      return AssetPath.nightCloudyLottie.path;
    } else if (lowerCase.contains('rain')) {
      return AssetPath.nightRainLottie.path;
    } else if (lowerCase.contains('clear')) {
      return AssetPath.nightClearLottie.path;
    } else if (lowerCase.contains('mist') || lowerCase.contains('fog')) {
      return AssetPath.nightFogLottie.path;
    } else if (lowerCase.contains('thunder')) {
      return AssetPath.thunderRainLottie.path;
    } else if (lowerCase.contains('free') || lowerCase.contains('ice')) {
      return AssetPath.nightIceLottie.path;
    } else {
      return AssetPath.nightCloudyLottie.path;
    }
  }
}