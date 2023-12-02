import 'package:weather_app/core/asset_paths.dart';

String getWeatherLottie(String weatherCondition, bool isDay) {
  final lowerCase = weatherCondition.toLowerCase();
  if(isDay) {
    if (lowerCase.contains('cloud')) {
      return AssetPaths.dayCloudyLottie.path;
    } else if (lowerCase.contains('rain')) {
      return AssetPaths.dayRainLottie.path;
    } else if (lowerCase.contains('sun')) {
      return AssetPaths.daySunnyLottie.path;
    } else if (lowerCase.contains('mist') || lowerCase.contains('fog')) {
      return AssetPaths.dayFogLottie.path;
    } else if (lowerCase.contains('thunder')) {
      return AssetPaths.thunderRainLottie.path;
    } else if (lowerCase.contains('free') || lowerCase.contains('ice')) {
      return AssetPaths.dayIceLottie.path;
    } else {
      return AssetPaths.dayCloudyLottie.path;
    }
  } else {
    if (lowerCase.contains('cloud')) {
      return AssetPaths.nightCloudyLottie.path;
    } else if (lowerCase.contains('rain')) {
      return AssetPaths.nightRainLottie.path;
    } else if (lowerCase.contains('clear')) {
      return AssetPaths.nightClearLottie.path;
    } else if (lowerCase.contains('mist') || lowerCase.contains('fog')) {
      return AssetPaths.nightFogLottie.path;
    } else if (lowerCase.contains('thunder')) {
      return AssetPaths.thunderRainLottie.path;
    } else if (lowerCase.contains('free') || lowerCase.contains('ice')) {
      return AssetPaths.nightIceLottie.path;
    } else {
      return AssetPaths.nightCloudyLottie.path;
    }
  }
}