import 'package:flutter/material.dart';
import 'package:weather_app/core/configs/env_config.dart';
import 'package:weather_app/core/configs/injectable_config.dart';
import 'package:weather_app/features/weather/screens/weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await EnvConfig.init(flavor: Flavor.dev);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GestureDetector(onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },child: WeatherScreen.newInstance()),
    );
  }
}
