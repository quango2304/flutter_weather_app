import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/core/svg_path.dart';
import 'package:weather_app/features/weather/blocs/location_bloc/location_bloc.dart';
import 'package:weather_app/features/weather/blocs/weather_cubit/weather_cubit.dart';
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

  void onSelectLocation(CityModel city) {}

  Widget buildBody() {
    return BlocBuilder<LocationBloc, LocationState>(builder: (_, state) {
      switch (state) {
        case LocationInitial():
          return buildWeatherData();
        case LocationSearching():
          return buildLocationList(state);
        case LocationSearchingFailed():
          return buildSearchFailed(state);
      }
    });
  }

  Widget buildLocationList(LocationSearching state) {
    final cities = state.cities;
    if (cities.isEmpty) {
      return SvgPicture.asset(SvgPath.noData.path);
    }
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (_, index) {
        final city = cities[index];
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          clipBehavior: Clip.hardEdge,
          child: CupertinoListTile(
            title: Text(city.name),
            subtitle: city.region.isNotEmpty ? Text(city.region) : null,
            additionalInfo: Text(city.country),
            onTap: () {
              searchTextController.clear();
              weatherCubit.getWeatherForLocation(cityName: city.name);
              locationBloc.add(const SearchLocationCompleteEvent());
            },
            backgroundColor: Colors.grey.withOpacity(0.1),
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
    return BlocBuilder<WeatherCubit, WeatherState>(builder: (_, state) {
      switch (state) {
        case WeatherInitial():
          return Text("Please choose location");
        case WeatherFetching():
          return CupertinoActivityIndicator();
        case WeatherFetchSuccessful():
          final weather = state.weather;
          return WeatherWidget(
            weather: weather,
          );
        case WeatherFetchFailed():
          return Text(state.message);
      }
    });
  }

  Widget buildSearchFailed(LocationSearchingFailed state) {
    return Text(state.message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: buildSearchField(),
          ),
          Expanded(child: buildBody()),
        ],
      ),
    );
  }

  Widget buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: TextField(
        onChanged: (keyword) {
          locationBloc.add(SearchLocationEvent(keyword));
        },
        decoration: InputDecoration(
          hintText: 'Search the location',
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        controller: searchTextController,
      ),
    );
  }
}
