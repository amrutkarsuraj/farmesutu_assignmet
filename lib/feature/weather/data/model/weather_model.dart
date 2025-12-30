class WeatherModel {
  final String cityName;
  final double temp;
  final int humidity;
  final String description;
  final String icon;

  WeatherModel({
    required this.cityName,
    required this.temp,
    required this.humidity,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temp: (json['main']['temp'] as num).toDouble(),
      humidity: json['main']['humidity'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
