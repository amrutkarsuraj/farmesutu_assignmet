import 'package:flutter/material.dart';
import 'package:farmsetu_assignment/feature/weather/domain/entity/forecast_entity.dart';

class ForecastList extends StatelessWidget {
  final List<ForecastEntity> forecast;

  const ForecastList({
    super.key,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    if (forecast.isEmpty) {
      return const Center(child: Text('No forecast data'));
    }

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = forecast[index];

          return Container(
            width: 90,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue.shade50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _formatDate(item.date),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 8),
                Image.network(
                  'https://openweathermap.org/img/wn/${item.icon}@2x.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  '${item.temperature.toStringAsFixed(0)}°C',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}';
  }
}
