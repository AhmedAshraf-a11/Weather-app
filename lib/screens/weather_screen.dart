import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../widgets/weather_search_form.dart';
import '../widgets/weather_display.dart';
import '../widgets/error_message.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  
  WeatherModel? weather;
  bool isLoading = false;
  String errorMessage = '';

  Future<void> _searchWeather(String cityName) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
      weather = null;
    });

    final result = await _weatherService.getWeather(cityName);

    setState(() {
      if (result.isSuccess) {
        weather = result.weather;
      } else {
        errorMessage = result.error ?? 'Unknown error occurred';
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WeatherSearchForm(
              onSearch: _searchWeather,
              isLoading: isLoading,
            ),
            if (errorMessage.isNotEmpty)
              ErrorMessage(message: errorMessage),
            if (weather != null)
              WeatherDisplay(weather: weather!),
          ],
        ),
      ),
    );
  }
}
