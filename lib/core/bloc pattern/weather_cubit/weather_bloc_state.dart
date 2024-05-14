part of 'weather_cubit.dart';

@immutable
sealed class WeatherCubitState {}

final class WeatherCubitInitial extends WeatherCubitState {}

final class WeatherCubitLoading extends WeatherCubitState {}

final class WeatherCubitCityFetch extends WeatherCubitState {
  final List<String> city;
  final TextEditingController controller;

  WeatherCubitCityFetch(this.controller, {required this.city});
}

final class WeatherCubitCitySelected extends WeatherCubitState {}

final class WeatherCityWeatherData extends WeatherCubitState {
  final String? data;

  WeatherCityWeatherData({required this.data});
}

final class WeatherError extends WeatherCubitState {
  final String? error;

  WeatherError({required this.error});
}
