import 'forecast_model.dart';

List<ForecastModel> mapFiveDayForecast(Map<String, dynamic> json) {
  final List list = json['list'];

  final Map<String, ForecastModel> dailyMap = {};

  for (final item in list) {
    final dateTime = DateTime.parse(item['dt_txt']);
    final dayKey = '${dateTime.year}-${dateTime.month}-${dateTime.day}';

    if (!dailyMap.containsKey(dayKey)) {
      dailyMap[dayKey] = ForecastModel(
        date: dateTime,
        minTemp: (item['main']['temp_min'] as num).toDouble(),
        maxTemp: (item['main']['temp_max'] as num).toDouble(),
        description: item['weather'][0]['description'],
        icon: item['weather'][0]['icon'],
      );
    }
  }

  return dailyMap.values.take(5).toList();
}
