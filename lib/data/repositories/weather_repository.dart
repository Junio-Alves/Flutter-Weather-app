import 'dart:convert';
import 'package:weather_app/data/http/http_client.dart';
import '../controller/position_controller.dart';
import 'package:weather_app/data/models/weather_model.dart';

abstract class IWeatherRepository {
  Future<WeatherModel> getWeather();
}

class WeatherRepository implements IWeatherRepository {
  final IHttpClient client;
  final PositionController positionController;
  final apiKey = 'b0988621';

  WeatherRepository({required this.positionController, required this.client});

  @override
  Future<WeatherModel> getWeather() async {
    final response = await client.get(
        url:
            'https://api.hgbrasil.com/weather?key=$apiKey&lat=${positionController.lat}&lon=${positionController.long}&user_ip=remote');

    if (response.statusCode == 200) {
      final WeatherModel weather;
      final body = jsonDecode(response.body);
      weather = WeatherModel.fromMap(body);
      return weather;
    } else if (response.statusCode == 404) {
      throw Exception("A url informada não é valida");
    } else {
      throw Exception("Não foi possivel localizar previsão.");
    }
  }
}
