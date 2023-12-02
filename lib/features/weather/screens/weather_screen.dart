import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/core/asset_path.dart';
import 'package:weather_app/features/weather/blocs/location_bloc/location_bloc.dart';
import 'package:weather_app/features/weather/blocs/weather_cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/widgets/location_list.dart';
import 'package:weather_app/features/weather/widgets/weather_widget.dart';
import 'package:weather_app/models/city.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen._({super.key});

  static Widget newInstance({Key? key}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationBloc(),
        ),
        BlocProvider(
          create: (context) => WeatherCubit(),
        ),
      ],
      child: WeatherScreen._(key: key),
    );
  }

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final searchTextController = TextEditingController();

  LocationBloc get locationBloc => context.read<LocationBloc>();

  WeatherCubit get weatherCubit => context.read<WeatherCubit>();

  bool isDay = true;

  @override
  void initState() {
    super.initState();
    weatherCubit.getWeatherForLocation(cityName: 'Ho Chi Minh city');
  }

  void onSelectLocation(CityModel city) {
    searchTextController.clear();
    weatherCubit.getWeatherForLocation(cityName: city.name);
    locationBloc.add(const SearchLocationCompleteEvent());
  }

  Widget buildBody() {
    return BlocBuilder<LocationBloc, LocationState>(builder: (_, state) {
      switch (state) {
        case LocationInitial():
          return buildWeatherData();
        case LocationSearching():
          return LocationListWidget(
            isDay: isDay,
            locations: state.cities,
            onSelectLocation: onSelectLocation,
          );
        case LocationSearchingFailed():
          return buildSearchFailed(state);
      }
    });
  }

  Widget buildLocationList(LocationSearching state) {
    final cities = state.cities;
    if (cities.isEmpty) {
      return SvgPicture.asset(AssetPath.noDataSvg.path);
    }
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (_, index) {
        final city = cities[index];
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
              searchTextController.clear();
              weatherCubit.getWeatherForLocation(cityName: city.name);
              locationBloc.add(const SearchLocationCompleteEvent());
            },
            backgroundColor:
                isDay ? const Color(0xffC2E0FF) : const Color(0xff131830),
          ),
        );
      },
      separatorBuilder: (_, index) => const SizedBox(
        height: 16,
      ),
      itemCount: cities.length,
    );
  }

  Widget buildWeatherData() {
    return BlocConsumer<WeatherCubit, WeatherState>(
      builder: (_, state) {
        switch (state) {
          case WeatherInitial():
            return const Text("Please choose location");
          case WeatherFetching():
            return const CupertinoActivityIndicator();
          case WeatherFetchSuccessful():
            final weather = state.weather;
            return WeatherWidget(
              weather: weather,
            );
          case WeatherFetchFailed():
            return Text(state.message);
        }
      },
      listener: (BuildContext context, WeatherState state) {
        switch (state) {
          case WeatherFetchSuccessful():
            setState(() {
              isDay = state.weather.current.isDay == 1;
            });
          default:
        }
      },
    );
  }

  Widget buildSearchFailed(LocationSearchingFailed state) {
    return Text(state.message);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: buildBackGroundDecoration(),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(child: buildBody()),
              buildSearchLocationTextField(),
            ],
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  Padding buildSearchLocationTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: TextField(
        onChanged: (keyword) {
          locationBloc.add(SearchLocationEvent(keyword));
        },
        style: TextStyle(color: isDay ? Colors.black : Colors.white),
        decoration: InputDecoration(
            hintText: 'Search the location',
            hintStyle: TextStyle(
                color: isDay
                    ? Colors.black.withOpacity(0.5)
                    : Colors.white.withOpacity(0.5)),
            suffixIcon: Icon(
              Icons.search,
              color: isDay
                  ? Colors.black.withOpacity(0.5)
                  : Colors.white.withOpacity(0.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20),
            ),
            fillColor:
                isDay ? const Color(0xffE5F3FF) : const Color(0xff39375E),
            filled: true),
        controller: searchTextController,
      ),
    );
  }

  BoxDecoration buildBackGroundDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
      begin: const Alignment(-1.0, -1.0),
      end: const Alignment(1.0, 1.0),
      stops: const [
        0.6,
        0.7,
      ],
      tileMode: TileMode.decal,
      colors: isDay
          ? const <Color>[
              Color(0xffE5F3FF),
              Color(0xffC2E0FF),
            ]
          : const [
              Color(0xff39375E),
              Color(0xff131830),
            ],
    ));
  }
}
