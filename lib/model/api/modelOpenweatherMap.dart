class ModelWeather {
  final String? name;
  final String? description;
  final String? icon;
  final double? temp;
  final double feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final double? windSpeed;
  final int? windDeg;
  final double? rainVolume;
  final int? cloudiness;
  final int? visibility;
  final int sunrise;
  final int sunset;

  ModelWeather({
    this.name = '',
    this.description = '',
    this.icon = '',
    this.temp = 0.0,
    this.feelsLike = 0.0,
    this.tempMin = 0.0,
    this.tempMax = 0.0,
    this.pressure = 0,
    this.humidity = 0,
    this.windSpeed = 0.0,
    this.windDeg = 0,
    this.rainVolume = 0.0,
    this.cloudiness = 0,
    this.visibility = 0,
    this.sunrise = 0,
    this.sunset = 0,
  });

  factory ModelWeather.fromJson(Map<String?, dynamic> json) {
    return ModelWeather(
      name: json['name'] ?? '',
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      temp: (json['main']['temp'] ?? 0.0).toDouble(),
      feelsLike: (json['main']['feels_like'] ?? 0.0).toDouble(),
      tempMin: (json['main']['temp_min'] ?? 0.0).toDouble(),
      tempMax: (json['main']['temp_max'] ?? 0.0).toDouble(),
      pressure: json['main']['pressure'] ?? 0,
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] ?? 0.0).toDouble(),
      windDeg: json['wind']['deg'] ?? 0,
      rainVolume: (json['rain'] != null && json['rain']['1h'] != null)
          ? (json['rain']['1h']).toDouble()
          : 0.0,
      cloudiness: json['clouds']['all'] ?? 0,
      visibility: json['visibility'] ?? 0,
      sunrise: json['sys']['sunrise'] ?? 0,
      sunset: json['sys']['sunset'] ?? 0,
    );
  }
}
