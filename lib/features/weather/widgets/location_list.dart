import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/core/asset_path.dart';
import 'package:weather_app/models/city.dart';

class LocationListWidget extends StatelessWidget {
  final bool isDay;
  final List<CityModel> locations;
  final ValueChanged<CityModel> onSelectLocation;

  const LocationListWidget(
      {super.key,
      required this.isDay,
      required this.locations,
      required this.onSelectLocation});

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return SvgPicture.asset(AssetPath.noDataSvg.path);
    }
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (_, index) {
        final city = locations[index];
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          clipBehavior: Clip.hardEdge,
          child: CupertinoListTile(
            title: Text(
              city.name,
              style: TextStyle(
                  color: isDay ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            padding: const EdgeInsets.all(20),
            subtitle: city.region.isNotEmpty
                ? Text(
                    city.region,
                    style: TextStyle(
                        color: isDay
                            ? Colors.black.withOpacity(0.5)
                            : Colors.white.withOpacity(0.5)),
                  )
                : null,
            additionalInfo: Text(
              city.country,
              style: TextStyle(
                  color: isDay
                      ? Colors.black.withOpacity(0.5)
                      : Colors.white.withOpacity(0.5)),
            ),
            onTap: () {
              onSelectLocation(city);
            },
            backgroundColor:
                isDay ? const Color(0xffC2E0FF) : const Color(0xff131830),
          ),
        );
      },
      separatorBuilder: (_, index) => const SizedBox(
        height: 16,
      ),
      itemCount: locations.length,
    );
  }
}
