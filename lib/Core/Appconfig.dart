import 'package:flutter/cupertino.dart';

class AppConfig extends ChangeNotifier {
  static AppConfig? instance;
  String baseUrl = "http://202.79.34.39:9670";
  String ipAddress = "";
  String port = "";
  List<String> databaseList = [];
  bool isBiometricEnabled = false;
  bool isGlobal = false;
  bool showProduction = false;

  factory AppConfig() {
    instance ??= AppConfig._();
    return instance!;
  }

  AppConfig._();
}