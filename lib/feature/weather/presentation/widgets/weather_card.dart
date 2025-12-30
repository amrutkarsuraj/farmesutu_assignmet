import 'package:flutter/material.dart';
import 'package:farmsetu_assignment/feature/weather/domain/entity/weather_entity.dart';

class WeatherCard extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              _getWeatherIconUrl(weather.icon),
              height: 80,
              width: 80,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.cloud,
                size: 80,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              weather.cityName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              weather.description.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.water_drop, size: 20),
                const SizedBox(width: 6),
                Text(
                  'Humidity: ${weather.humidity}%',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}
