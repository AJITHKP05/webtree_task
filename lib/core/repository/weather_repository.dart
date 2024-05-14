import 'package:dio/dio.dart';

import '../constants/app_urls.dart';

class WeatherRepository {
  final dio = Dio();
  Future<List<String>> getCities() async {
    List<String> dummyData = [];
    try {
      final response = await dio.get(AppUrl.cityUrl);
      // print(response.data['data']);
      for (var x in (response.data['data'] as List)) {
        dummyData.add(x['city']);
      }
      return dummyData;
    } catch (e) {
      rethrow;
    }
  }

  void getWeather(String city) {}
}
