import 'package:flutter/material.dart';
import 'package:weather_app/data/controller/position_controller.dart';
import 'package:weather_app/data/http/http_client.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherRepository repository =
      WeatherRepository(PositionController(), client: HttpClient());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
      ),
      body: FutureBuilder(
          future: repository.getWeather(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              WeatherModel weather = snapshot.data!;
              return Text(
                  '${weather.city} ${weather.temp} ${weather.description} ');
            }
          })),
    );
  }
}
