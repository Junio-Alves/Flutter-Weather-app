import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/provider/weather_providery.dart';
import 'package:weather_app/pages/widgets/imageIcon.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provider = Provider.of<WeatherProvider>(context, listen: false);
    provider.getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("Build Called");
    final provider = Provider.of<WeatherProvider>(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: provider.isLoanding
          ? getLoadingUI()
          : provider.error.isNotEmpty
              ? getErrorUI(provider.error)
              : getBodyUI(provider.weathers),
    );
  }

  Widget getLoadingUI() {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitCircle(
            color: Colors.blue,
            size: 50,
          )
        ],
      ),
    );
  }

  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 50),
      ),
    );
  }

  Widget getBodyUI(List<WeatherModel> weathers) {
    WeatherModel weather = weathers[0];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 130,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            weather.city,
            style: const TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Row(
            children: [
              Text(
                "${weather.temp}°",
                style: const TextStyle(
                  fontSize: 90,
                  color: Colors.white,
                ),
              ),
              Text(
                "${weather.description}  ${weather.date}",
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageIcon(weather.currently),
              height: 200,
              width: 200,
            )
          ],
        ),
        const SizedBox(
          height: 150,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 100,
              constraints: const BoxConstraints(
                maxHeight: 400,
                maxWidth: 400,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30)),
              child: ListView.builder(
                  itemCount: weather.forecast.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 90),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            imageIcon(weather.forecast[index]["condition"]),
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${weather.forecast[index]["weekday"]} ${weather.forecast[index]["date"]}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        )
      ],
    );
  }
}
