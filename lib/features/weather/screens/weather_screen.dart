import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/blocs/location_bloc/location_bloc.dart';
import 'package:weather_app/features/weather/blocs/weather_cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/widgets/weather_widget.dart';
import 'package:weather_app/models/city.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage._({super.key});

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
      child: MyHomePage._(key: key),
    );
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      return Text('Not found any city with the name');
    }
    return ListView.builder(
      itemBuilder: (_, index) {
        final city = cities[index];
        return CupertinoListTile(
          title: Text(city.name),
          subtitle: Text('${city.country} ${city.region}'),
          onTap: () {
            searchTextController.clear();
            weatherCubit.getWeatherForLocation(cityName: city.name);
            locationBloc.add(const SearchLocationCompleteEvent());
          },
        );
      },
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
          return WeatherWidget(weather: weather,);
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              onChanged: (keyword) {
                if(keyword.isEmpty) {
                  locationBloc.add(const SearchLocationCompleteEvent());
                } else {
                  locationBloc.add(SearchLocationEvent(keyword));
                }
              },
              controller: searchTextController,
            ),
            Expanded(child: buildBody())
          ],
        ),
      ),
    );
  }
}
