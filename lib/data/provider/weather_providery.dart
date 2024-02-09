import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../controller/position_controller.dart';
import 'package:weather_app/data/models/weather_model.dart';
import "package:http/http.dart" as http;

class WeatherProvider extends ChangeNotifier {
  final positionController = PositionController();
  final apiKey = 'b0988621';
  List<WeatherModel> weathers = [];
  bool isLoanding = true;
  String error = '';

  Future getWeather() async {
    try {
      await positionController.getPosition();
      final result = await http.get(Uri.parse(
          'https://api.hgbrasil.com/weather?key=$apiKey&lat=${positionController.lat}&lon=${positionController.long}&user_ip=remote'));

      if (result.statusCode == 200) {
        final body = jsonDecode(result.body);
        weathers.add(WeatherModel.fromMap(body['results']));
      } else if (result.statusCode == 404) {
        error = result.statusCode.toString();
        throw Exception("A url informada não é valida");
      } else {
        error = result.statusCode.toString();
        throw Exception("Não foi possivel localizar previsão.");
      }
    } catch (e) {
      error = e.toString();
    }
    isLoanding = false;
    notifyListeners();
  }
}
