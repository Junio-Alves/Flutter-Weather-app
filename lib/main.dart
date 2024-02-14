import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/provider/weather_provider.dart';
import 'package:weather_app/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

Color? color;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => WeatherProvider()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: ThemeData(scaffoldBackgroundColor: color),
      ),
    );
  }
}
