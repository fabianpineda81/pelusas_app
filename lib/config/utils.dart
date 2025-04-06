import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils{
  static Future<void> safeLaunchUrl(String url) async {
    final uri = Uri.parse(url);
    try{
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }catch (e) {
      if (kDebugMode) {
        print('Error al abrir la URL: $e');
      }
    }
  }
}

