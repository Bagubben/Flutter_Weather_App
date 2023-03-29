import 'dart:convert';

import 'package:flutter_weather_app/models/models.dart';
import 'package:http/http.dart' as http;

class WeatherServiceAPI {
  WeatherServiceAPI();

  Future<WeatherDatetime> fetchWeatherRequest() async {
    /*
    String json ='{"type":"Feature","geometry":{"type":"Point","coordinates":[12.9725,55.608,4]},"properties":{"meta":{"updated_at":"2023-03-24T08:36:49Z",	"units":{"air_pressure_at_sea_level":"hPa","air_temperature":"celsius","cloud_area_fraction":"%","precipitation_amount":"mm","relative_humidity":"%","wind_from_direction":"degrees","wind_speed":"m/s"}},"timeseries":[{"time":"2023-03-24T09:00:00Z","data":{"instant":{"details":{"air_pressure_at_sea_level":992.2,"air_temperature":8.3,"cloud_area_fraction":100.0,"relative_humidity":96.0,"wind_from_direction":200.6,"wind_speed":9.6}},"next_12_hours":{"summary":{"symbol_code":"lightrainshowers_day"}},"next_1_hours":{"summary":{"symbol_code":"rain"},"details":{"precipitation_amount":0.9}},"next_6_hours":{"summary":{"symbol_code":"lightrainshowers_day"},"details":{"precipitation_amount":0.9}}}}]}}';
    
    return json;
    */
    
    final response = await http.get(
      Uri.parse(
          'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=55.607997568&lon=12.97249611'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept-Charset': 'utf-8',
      /* 'User-Agent': 'curl/7.19.7 (x86_64-redhat-linux-gnu) libcurl/7.19.7 NSS/3.15.3 zlib/1.2.3 libidn/1.18 libssh2/1.4.2',*/
      'User-Agent': 'Flutter Example Weather APP',
      },
    );

    
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      
      /*
      print(responseMap['properties']['timeseries'][0]['data']['instant']);
      
      return WeatherDatetime();
      */
      Map<String,String> timeSerie = {
        'airPressureAtSeaLevel': "${responseMap['properties']['timeseries'][0]['data']['instant']['details']['air_pressure_at_sea_level']}", 
        'airTemperature': "${responseMap['properties']['timeseries'][0]['data']['instant']['details']['air_temperature']}", 
        'cloudAreaFraction': "${responseMap['properties']['timeseries'][0]['data']['instant']['details']['cloud_area_fraction']}",  
        'relativeHumidity': "${responseMap['properties']['timeseries'][0]['data']['instant']['details']['relative_humidity']}",  
        'windFromDirection': "${responseMap['properties']['timeseries'][0]['data']['instant']['details']['wind_from_direction']}",   
        'windSpeed': "${responseMap['properties']['timeseries'][0]['data']['instant']['details']['wind_speed']}",  
      };
      
      WeatherDatetime weatherDatetime = WeatherDatetime(
        airPressureAtSeaLevel: timeSerie['airPressureAtSeaLevel'],
        airTemperature: timeSerie['airTemperature'],
        cloudAreaFraction: timeSerie['cloudAreaFraction'],
        relativeHumidity: timeSerie['relativeHumidity'],
        windFromDirection: timeSerie['windFromDirection'],
        windSpeed: timeSerie['windSpeed'],
      ); 
      
      return weatherDatetime;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to read API response.');
    }
  }
}
