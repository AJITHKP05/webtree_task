import 'package:dio/dio.dart';
import 'package:webtree_task/presentation/models/weather.dart';

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

  Future<Weather> getWeather(String city) async {
    late Weather data;
    try {
      final response = await dio.get(AppUrl.weatherDetailUrl,
          options: Options(headers: {
            "Accept": "*/*",
            "X-Api-Key": "kNdezYSOlAcRomCK+4Ddrw==OPcBW6x8XiNeRguh"
          }));
      if (response.statusCode == 200) {
        data = Weather(
            windSpeed: response.data["wind_speed"],
            cloudPct: response.data["cloud_pct"],
            feelsLike: response.data["feels_like"],
            humidity: response.data["humidity"],
            maxTemp: response.data["max_temp"],
            minTemp: response.data["min_temp"],
            sunrise: response.data["sunrise"],
            sunset: response.data["sunset"],
            temp: response.data["temp"],
            windDegrees: response.data["wind_degrees"]);
      } else {
        throw Exception();
      }

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
