import 'package:flutter_weather_app/models/weather_datetime.dart';
import 'package:flutter_weather_app/services/weather_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/weather_service_api.dart';

final weatherDatetimeFutureProvivder = FutureProvider(
  (ref) {
    return ref.watch(weatherServiceProvider).getWeather();
  },
);

final weatherServiceApiProvider = Provider<WeatherServiceAPI>((ref) {
  return WeatherServiceAPI();
});

final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService(weatherServiceAPI: ref.read(weatherServiceApiProvider));
});

final weatherNotifier =
    StateNotifierProvider<WeatherAsyncNotifier, AsyncValue<WeatherDatetime>>(
        (ref) => WeatherAsyncNotifier(ref));

class WeatherAsyncNotifier extends StateNotifier<AsyncValue<WeatherDatetime>> {
  WeatherAsyncNotifier(this.ref) : super(AsyncData(WeatherDatetime())) {
    reload(); // It's same as initState();
  }

  final Ref ref;

  void reload() async {
    state = const AsyncLoading();
    WeatherDatetime weatherDatetime =
        await ref.read(weatherServiceProvider).getWeather();
    state = AsyncData(weatherDatetime);
  }
/*
  Future<void> refresh() async {
    state = const AsyncLoading();
    WeatherDatetime weatherDatetime =
        await ref.read(weatherServiceProvider).getWeather();
    state = AsyncData(weatherDatetime);
    
  }
  */
}
