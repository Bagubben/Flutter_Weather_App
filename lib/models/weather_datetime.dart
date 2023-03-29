import 'dart:core';

class WeatherDatetime {
  
  /*
  {time: 2023-03-24T10:00:00Z, 
  data: {instant: 
  {details: 
  {
    air_pressure_at_sea_level: 992.3, 
    air_temperature: 8.5, 
    cloud_area_fraction: 100.0, 
    relative_humidity: 95.8, 
    wind_from_direction: 211.8, 
    wind_speed: 9.9
    }
  }, 
    next_12_hours: 
      {summary: 
        {symbol_code: partlycloudy_day}
      }, 
        next_1_hours: 
        {
          summary: {symbol_code: cloudy}, 
          details: {precipitation_amount: 0.0}
        }, 
        next_6_hours:
        {
          summary: {symbol_code: partlycloudy_day}, 
          details: {precipitation_amount: 0.0}}}}
  */
    String? airPressureAtSeaLevel; // : 992.3, 
    String? airTemperature; //: 8.5, 
    String? cloudAreaFraction; // : 100.0, 
    String? relativeHumidity; //: 95.8, 
    String? windFromDirection; //: 211.8, 
    String? windSpeed; //: 9.9
    
    WeatherDatetime({this.airPressureAtSeaLevel, this.airTemperature, this.cloudAreaFraction,
    this.relativeHumidity, this.windFromDirection, this.windSpeed});
    
  @override
  String toString() {
    return "airPressureAtSeaLevel:${airPressureAtSeaLevel}, airTemperature:${airTemperature}, cloudAreaFraction: ${cloudAreaFraction}, relativeHumidity:${relativeHumidity}, windFromDirection:${windFromDirection}, windSpeed:${windSpeed}";
  }
}