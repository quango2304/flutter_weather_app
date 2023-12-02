enum AssetPath {
  noDataSvg('assets/svgs/no-data.svg'),
  nightRainLotties('assets/lotties/night-rain.json'),
  dayRainLotties('assets/lotties/day-rain.json'),
  nightClearLotties('assets/lotties/clear-night.json'),
  dayCloudyLotties('assets/lotties/cloudy-day.json'),
  nightCloudyLotties('assets/lotties/cloudy-night.json'),
  dayFogLotties('assets/lotties/day-fog.json'),
  dayIceLotties('assets/lotties/day-ice.json'),
  nightFogLotties('assets/lotties/night-fog.json'),
  nightIceLotties('assets/lotties/night-ice.json'),
  daySunnyLotties('assets/lotties/sunny-day.json'),
  thunderRainLotties('assets/lotties/thunder-rain.json'),

  ;

  const AssetPath(this.path);

  final String path;
}
