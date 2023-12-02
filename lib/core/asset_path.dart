enum AssetPath {
  noDataLottie('assets/lotties/no-data.json'),
  errorLottie('assets/lotties/error.json'),
  nightRainLottie('assets/lotties/night-rain.json'),
  dayRainLottie('assets/lotties/day-rain.json'),
  nightClearLottie('assets/lotties/clear-night.json'),
  dayCloudyLottie('assets/lotties/cloudy-day.json'),
  nightCloudyLottie('assets/lotties/cloudy-night.json'),
  dayFogLottie('assets/lotties/day-fog.json'),
  dayIceLottie('assets/lotties/day-ice.json'),
  nightFogLottie('assets/lotties/night-fog.json'),
  nightIceLottie('assets/lotties/night-ice.json'),
  daySunnyLottie('assets/lotties/sunny-day.json'),
  thunderRainLottie('assets/lotties/thunder-rain.json'),
  ;

  const AssetPath(this.path);

  final String path;
}
