
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_today/core/location/get_locaton.dart';
import 'package:weather_today/domain/home_screen/weather_data.dart';
import 'package:weather_today/infrastructure/api_key.dart';

class WeatherDataFromApi {
   Future<WeatherData?> getCurrentWeatherData() async {
    try {
      Dio dio =
          Dio(BaseOptions(baseUrl: 'https://api.openweathermap.org/data/2.5'));

      Position position = await determinePosition();

      final Response response = await dio.get('/weather?&appid=$apiKey',
          queryParameters: {
            "lat": position.latitude,
            "lon": position.longitude
          });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final resp = response.data;
        return WeatherData.fromJson(resp);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

   Future<WeatherData?> getSearchtWeatherData(String place) async {
    try {
      Dio dio =
          Dio(BaseOptions(baseUrl: 'https://api.openweathermap.org/data/2.5'));

      final Response response = await dio
          .get('/weather?&appid=$apiKey', queryParameters: {"q": place});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final resp = response.data;

        return WeatherData.fromJson(resp);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
