import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherResult {
  final WeatherModel? weather;
  final String? error;
  final bool isSuccess;

  WeatherResult({this.weather, this.error, required this.isSuccess});

  factory WeatherResult.success(WeatherModel weather) {
    return WeatherResult(weather: weather, isSuccess: true);
  }

  factory WeatherResult.error(String error) {
    return WeatherResult(error: error, isSuccess: false);
  }
}

class WeatherService {
  static const String apiKey =
      'b7d0cf068f5a6f05cbd3dac49f2c4747'; // Replace with your API key
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherResult> getWeather(String cityName) async {
    // Input validation
    if (cityName.trim().isEmpty) {
      return WeatherResult.error('Please enter a city name');
    }

    try {
      final url = '$baseUrl?q=${cityName.trim()}&appid=$apiKey&units=metric';

      final response = await http
          .get(Uri.parse(url))
          .timeout(
            Duration(seconds: 10),
            onTimeout: () {
              throw Exception('Request timeout');
            },
          );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final weather = WeatherModel.fromJson(jsonData);
        return WeatherResult.success(weather);
      } else if (response.statusCode == 404) {
        return WeatherResult.error(
          'City not found. Please check the city name.',
        );
      } else if (response.statusCode == 401) {
        return WeatherResult.error(
          'Invalid API key. Please check configuration.',
        );
      } else {
        return WeatherResult.error('Failed to fetch weather data');
      }
    } catch (e) {
      if (e.toString().contains('timeout')) {
        return WeatherResult.error(
          'Request timeout. Please check your internet connection.',
        );
      } else if (e.toString().contains('SocketException')) {
        return WeatherResult.error('No internet connection');
      } else {
        return WeatherResult.error('Something went wrong. Please try again.');
      }
    }
  }
}
