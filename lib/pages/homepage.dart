import 'package:flutter/material.dart';
import 'package:weather_app/data/controller/position_controller.dart';
import 'package:weather_app/data/http/http_client.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/pages/widgets/backgroundcolor.dart';
import 'package:weather_app/pages/widgets/imageIcon.dart';

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
            return Center(child: Text(snapshot.error.toString()));
          } else {
            WeatherModel weather = snapshot.data!;

            if (weather.currently == "dia") {
              backgrouncolor(Colors.blue);
            } else if (weather.currently == "noite") {
              backgrouncolor(const Color.fromARGB(255, 36, 46, 97));
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
                      imageIcon(weather.currently),
                      height: 200,
                      width: 200,
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      height: 100,
                      constraints: const BoxConstraints(
                        maxHeight: 300,
                        maxWidth: 400,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30)),
                      child: ListView.builder(
                          itemCount: weather.forecast.length,
                          itemBuilder: (context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    imageIcon(
                                        weather.forecast[index]["condition"]),
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
        }),
      ),
    );
  }
}
