import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_today/domain/home_screen/weather_data.dart';
import 'package:weather_today/infrastructure/home_screen/weather_data_api.dart';

class HomeScreenProvider extends ChangeNotifier {
  WeatherDataFromApi weatherDataFromApi = WeatherDataFromApi();
  WeatherData? data;
  bool isLoading = true;
  Future<void> getWeather() async {
    log('message');
    isLoading = true;
    data = await weatherDataFromApi.getCurrentWeatherData();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getSearch(String place) async {
    isLoading = true;
    data = await weatherDataFromApi.getSearchtWeatherData(place);
    isLoading = false;
    notifyListeners();
  }
}
