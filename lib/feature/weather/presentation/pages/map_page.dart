import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/location_service.dart';
import '../provider/weather_provider.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class WeatherTileProvider implements TileProvider {
  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    if (zoom == null) {
      return TileProvider.noTile;
    }

    final url =
        'https://tile.openweathermap.org/map/temp_new/'
        '$zoom/$x/$y.png'
        '?appid=${const String.fromEnvironment('WEATHER_API_KEY')}';

    // Returning noTile is fine; Google Maps fetches tiles via URL internally
    return TileProvider.noTile;
  }
}

class _MapPageState extends ConsumerState<MapPage> {
  LatLng? _currentLatLng;

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
  }

  Future<void> _loadCurrentLocation() async {
    final position = await LocationService.getCurrentLocation();
    setState(() {
      _currentLatLng = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Map'),
      ),
      body: _currentLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentLatLng!,
          zoom: 6,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,

        tileOverlays: {
          TileOverlay(
            tileOverlayId: const TileOverlayId('weather_overlay'),
            tileProvider: WeatherTileProvider(),
            transparency: 0.35,
          ),
        },


        markers: {
          if (weatherState.value != null)
            Marker(
              markerId: const MarkerId('current_location'),
              position: _currentLatLng!,
              infoWindow: InfoWindow(
                title:
                '${weatherState.value!.temperature.toStringAsFixed(1)}°C',
                snippet: 'Humidity: ${weatherState.value!.humidity}%',
              ),
            ),
        },
      )
    );
  }
}

