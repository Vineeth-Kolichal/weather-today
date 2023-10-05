import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_today/application/home_screen_provider/home_screen_provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Weather today',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              style: const TextStyle(color: Colors.white),
              itemColor: Colors.white,
              onSubmitted: (value) async {
                if (value.isEmpty) {
                } else {
                  context.read<HomeScreenProvider>().getSearch(value.trim());
                  // await WeatherDataFromApi.getSearchtWeatherData(value.trim());
                }
              },
              onChanged: (value) async {
                if (value.isNotEmpty) {
                  context.read<HomeScreenProvider>().getSearch(value.trim());
                }
              },
              backgroundColor: const Color.fromARGB(103, 82, 81, 81),
              placeholder: 'Search place',
              placeholderStyle:
                  const TextStyle(color: Color.fromARGB(255, 214, 213, 213)),
            ),
          )),
        ],
      ),
    );
  }
}
