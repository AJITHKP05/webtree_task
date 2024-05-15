import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../repository/weather_repository.dart';

part 'weather_bloc_state.dart';

class WeatherCubit extends Cubit<WeatherCubitState> {
  WeatherCubit() : super(WeatherCubitInitial());
  final repo = WeatherRepository();
  List<String> cities = [];
  List<String> searchCities = [];
  String selectedCity = "";
  TextEditingController cont = TextEditingController();
  Future getCities() async {
    emit(WeatherCubitLoading());
    try {
      if (cities.isEmpty) {
        cities = await repo.getCities();
      }
      emit(WeatherCubitCityFetch(cont, city: cities));
    } catch (e) {
      emit(WeatherError(
          error: "Coudn't fetch the data, please pull down to try again"));
    }
  }

  onSelected(String data) {
    selectedCity = data;
    cont.text = data;
    emit(WeatherCubitCitySelected());
  }
}
