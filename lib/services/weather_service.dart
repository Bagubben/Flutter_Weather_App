import 'package:flutter_weather_app/models/models.dart';
import 'package:flutter_weather_app/services/weather_service_api.dart';

class WeatherService {
  WeatherServiceAPI weatherServiceAPI;

  WeatherService({required this.weatherServiceAPI});
  
  Future<WeatherDatetime> getWeather() async {
    
    final res = await weatherServiceAPI.fetchWeatherRequest();
    return res;
  }
  
}