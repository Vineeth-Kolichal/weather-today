import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_today/application/home_screen_provider/home_screen_provider.dart';
import 'package:weather_today/core/constants.dart';
import 'package:weather_today/presentation/widgets/custom_appbar.dart';

import 'widgets/weather_details_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateFormat formater = DateFormat.yMMMMd();
    String dateToday = formater.format(today);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(105), child: CustomAppBar()),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: ShowWeatherData(
            dateToday: dateToday,
            size: size,
          ),
        ),
      ),
    );
  }
}

class ShowWeatherData extends StatelessWidget {
  const ShowWeatherData({
    super.key,
    required this.dateToday,
    required this.size,
  });

  final String dateToday;
  final Size size;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenProvider>().getWeather();
    });

    return Consumer<HomeScreenProvider>(builder: (context, homeProvider, _) {
      if (homeProvider.isLoading) {
        return const Center(
          child: SpinKitWave(
            color: Colors.white,
            size: 60.0,
          ),
        );
      }
      if (homeProvider.data == null) {
        return const Center(
          child: Text('Something went wrong'),
        );
      }

      return ListView(
        children: [
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
              ),
              Text(
                '${homeProvider.data?.name}',
                style: const TextStyle(fontSize: 30),
              ),
            ],
          ),
          Center(child: Text(dateToday)),
          kHeight10,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${((homeProvider.data!.main!.temp!) - 273.15).round()}',
                  style: const TextStyle(
                      fontSize: 140, fontWeight: FontWeight.w500),
                ),
                const Text(
                  'o',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                const Text('C', style: TextStyle(fontSize: 50))
              ],
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width * 0.95,
                //height: size.width * 0.8,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(103, 82, 81, 81),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    WeatherItemWidget(
                      icon: const Icon(Icons.water_drop_outlined),
                      title: 'Humidity',
                      value: '${homeProvider.data?.main?.humidity}%',
                    ),
                    const Divider(),
                    WeatherItemWidget(
                      icon: const Icon(Icons.cloud),
                      title: 'Cloud Cover',
                      value: '${homeProvider.data?.clouds?.all}%',
                    ),
                    const Divider(),
                    WeatherItemWidget(
                      icon: const Icon(Icons.speed),
                      title: 'Pressure',
                      value: '${homeProvider.data?.main?.pressure} hPa',
                    ),
                    const Divider(),
                    WeatherItemWidget(
                      icon: const Icon(CupertinoIcons.speedometer),
                      title: 'Wind Speed',
                      value: '${homeProvider.data?.wind?.speed} m/s',
                    ),
                  ]),
                ),
              ),
            ),
          ),
          kHeight10,
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
              childAspectRatio: 2.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(103, 82, 81, 81),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Latitude',
                              style: TextStyle(fontSize: 20)),
                          Text('${homeProvider.data?.coord?.lat}',
                              style: const TextStyle(fontSize: 17)),
                        ]),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(103, 82, 81, 81),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Longitude',
                              style: TextStyle(fontSize: 20)),
                          Text('${homeProvider.data?.coord?.lon}',
                              style: const TextStyle(fontSize: 17)),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          kHeight10
        ],
      );
    });
  }
}
