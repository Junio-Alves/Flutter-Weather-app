class WeatherModel {
  String temp;
  String date;
  String time;
  String description;
  String currently;
  String city;
  String humidity;
  List<dynamic> forecast;

  WeatherModel(
      {required this.temp,
      required this.date,
      required this.time,
      required this.description,
      required this.currently,
      required this.city,
      required this.humidity,
      required this.forecast});

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      temp: map['results']['temp'].toString(),
      date: map['results']['date'].toString(),
      time: map['results']['time'].toString(),
      description: map['results']['description'].toString(),
      currently: map['results']['currently'].toString(),
      city: map['results']['city'].toString(),
      humidity: map['results']['humidity:'].toString(),
      forecast: map['results']['forecast'],
    );
  }
}
