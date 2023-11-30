import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/blocs/location_bloc/location_bloc.dart';
import 'package:weather_app/models/city.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage._({super.key});

  static Widget newInstance({Key? key}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationBloc(),
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

  void onSelectLocation(CityModel city) {

  }

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
          subtitle: Text(city.country),
          onTap: () {
            searchTextController.clear();
            locationBloc.add(SearchLocationCompleteEvent());
          },
        );
      },
      itemCount: cities.length,
    );
  }

  Widget buildWeatherData() {
    return Text('weather data here');
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
                locationBloc.add(SearchLocationEvent(keyword));
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