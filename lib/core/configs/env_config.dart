
import 'package:flutter_dotenv/flutter_dotenv.dart';
enum Flavor { dev }

class EnvConfig {
  const EnvConfig._();

  static late final Map<String, String> _environment;

  static String get weatherApiKey => _environment['WEATHER_API_KEY']!;

  static Future<void> init({Flavor flavor = Flavor.dev}) async {
    String envFileName;
    switch (flavor) {
      case Flavor.dev:
        envFileName = 'env/.env';
        break;
    }
    await dotenv.load(fileName: envFileName);
    _environment = dotenv.env;
  }
}