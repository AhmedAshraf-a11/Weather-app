import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              weather.cityName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Image.network(
              weather.iconUrl,
              width: 80,
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.wb_sunny, size: 80);
              },
            ),
            SizedBox(height: 16),
            Text(
              weather.temperatureString,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(weather.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text('Humidity: ${weather.humidity}%'),
          ],
        ),
      ),
    );
  }
}
