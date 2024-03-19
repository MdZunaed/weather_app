class DailyWeatherModel {
  final int dt;
  final double temp;
  final double minTemp;
  final double maxTemp;
  final String weatherIcon;

  DailyWeatherModel({
    required this.dt,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.weatherIcon,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    return DailyWeatherModel(
      dt: json['dt'],
      minTemp: json['main']['temp'].toDouble(),
      temp: json['main']['temp_min'].toDouble(),
      maxTemp: json['main']['temp_max'].toDouble(),
      weatherIcon: json['weather'][0]['icon'],
    );
  }
}
