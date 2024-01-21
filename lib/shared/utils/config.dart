import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get urlBaseBack4App => _get('BACK4APP_BASE_URL');
  static String get applicationIdBack4App => _get('BACK4APP_APPLICATION_ID');
  static String get aPIKeyBack4App => _get('BACK4APP_API_KEY');
  static String get contentTypeBack4App => _get('BACK4APP_CONTENT_TYPE');
  static String _get(String name) => dotenv.get(name);
}
