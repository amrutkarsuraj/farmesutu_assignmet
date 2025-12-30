import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/weather_provider.dart';
import '../provider/forecast_provider.dart';
import '../widgets/weather_card.dart';
import '../widgets/forecast_list.dart';
import 'map_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherProvider);
    final forecastState = ref.watch(forecastProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MapPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: weatherState.when(
          data: (weather) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Search city (e.g. Mumbai)',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onSubmitted: (city) {
                      ref.read(weatherProvider.notifier).fetchWeatherByCity(city);
                      ref.read(forecastProvider.notifier).fetchForecastByCity(city);
                    },
                  ),
                  const SizedBox(height: 24),
                  if (weather != null)
                    Center(child: WeatherCard(weather: weather))
                  else
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(weatherProvider.notifier)
                              .fetchWeather();
                          ref
                              .read(forecastProvider.notifier)
                              .fetchForecast();
                        },
                        child: const Text('Load Weather'),
                      ),
                    ),
                  const SizedBox(height: 24),
                  const Text(
                    '5-Day Forecast',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),
                  forecastState.when(
                    data: (forecast) =>
                        ForecastList(forecast: forecast),
                    loading: () => const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (e, _) => Column(
                      children: [
                        Text(e.toString()),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            ref
                                .read(forecastProvider.notifier)
                                .fetchForecast();
                          },
                          child: const Text('Retry Forecast'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () =>
          const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(e.toString()),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    ref.read(weatherProvider.notifier).fetchWeather();
                    ref.read(forecastProvider.notifier).fetchForecast();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
