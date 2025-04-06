import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  static String apiKey = dotenv.env['CAT_API_KEY'] ?? '';
}