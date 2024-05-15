import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webtree_task/presentation/models/weather.dart';

import '../../repository/weather_repository.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailInitial());
  final repo = WeatherRepository();
  Weather? data;
  getDetail(String cityName) async {
    emit(DetailLoading());
    try {
      data = await repo.getWeather(cityName);
      emit(DetailDataLoaded(data: data));
    } catch (e) {
      emit(DetailError(
          error: "Coudn't fetch the data, please pull down to try again"));
    }
  }
}
