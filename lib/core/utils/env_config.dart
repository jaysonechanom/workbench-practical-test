
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static const String localDbName = "dbName";
  static const String localDbPassword = "dbPassword";

  ///**
  ///Initialize Env, make sure .env file is declared in pubspec.yaml asset section
  Future<void> initEnv() async {
    await dotenv.load(fileName: "env/secrets.env");
  }

  String getValue(String varName) {
    return dotenv.get(varName);
  }

  DotEnv getEnv() {
    return dotenv;
  }
}