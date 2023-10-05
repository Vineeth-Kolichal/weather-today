import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_today/application/home_screen_provider/home_screen_provider.dart';

import 'presentation/home_screen/home_screen.dart';

void main(List<String> args) {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          //scaffoldBackgroundColor:const Color.fromARGB(218, 144, 174, 202),
          brightness: Brightness.dark,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
