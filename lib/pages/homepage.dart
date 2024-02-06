import 'package:flutter/material.dart';
import 'package:weather_app/data/controller/position_controller.dart';
import 'package:weather_app/data/http/http_client.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherRepository repository = WeatherRepository(
      positionController: PositionController(), client: HttpClient());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: repository.getWeather(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            WeatherModel weather = snapshot.data!;
            if (weather.currently == "noite") {
              color = Colors.purple;
            } else {
              color = Colors.blue;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 150, left: 20),
                  child: Text(
                    weather.city,
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
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
                            fontWeight: FontWeight.bold),
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
                      imageIcon(weather),
                      height: 250,
                      width: 250,
                    )
                  ],
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  String imageIcon(WeatherModel weather) {
    if (weather.currently == "noite") {
      return 'assets/icons/clear_night.png';
    } else {
      return 'assets/icons/clear_day.png';
    }
  }
}
