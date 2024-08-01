import 'dart:convert';
import 'package:flutter/services.dart';

class Environment {
  final String appName;
  final String apiBaseUrl;
  final String logLevel;

  Environment({
    required this.appName,
    required this.apiBaseUrl,
    required this.logLevel,
  });

  static Future<Environment> load(String environment) async {
    final configString =
        await rootBundle.loadString('assets/config/$environment.json');
    final configJson = json.decode(configString);
    return Environment.fromJson(configJson);
  }

  factory Environment.fromJson(Map<String, dynamic> json) {
    return Environment(
      appName: json['appName'],
      apiBaseUrl: json['apiBaseUrl'],
      logLevel: json['logLevel'],
    );
  }

  /// Factory method to create an Environment based on the environment.
  factory Environment.fromEnvironment(String environment) {
    switch (environment) {
      case 'development':
        return Environment(
          appName: 'Medi Express Patient (Development)',
          apiBaseUrl: 'http://api-stg.combros.tech:10110/',
          logLevel: 'debug',
        );
      case 'production':
        return Environment(
          appName: 'Medi Express Patient',
          apiBaseUrl: 'https://api.example.com',
          logLevel: 'error',
        );
      case 'staging':
        return Environment(
          appName: 'Medi Express Patient (Staging)',
          apiBaseUrl: 'https://staging-api.example.com',
          logLevel: 'info',
        );
      default:
        throw ArgumentError('Invalid environment: $environment');
    }
  }
}
