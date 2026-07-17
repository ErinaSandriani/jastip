import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiService {

  static String get baseUrl {

    if (kIsWeb) {
      return "http://localhost:8000";
    }

    if (Platform.isAndroid) {
      return "http://192.168.1.8:8000";
    }

    if (Platform.isLinux) {
      return "http://localhost:8000";
    }

    return "http://localhost:8000";
  }
}