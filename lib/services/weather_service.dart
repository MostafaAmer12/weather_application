import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {
  WeatherModel? weather;
  String baseUrl = 'https://api.openweathermap.org/data/2.5/';
  String apiKey = 'bb8530ea505faf71ca518897e2bf7a96';

  Future<WeatherModel?> getWeather({required String cityName}) async {
    try {
      Uri url =
          Uri.parse('$baseUrl/weather?q=$cityName&appid=$apiKey');
      http.Response response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);

      weather = WeatherModel.fromJson(data);
    } catch (e) {
      print(e);
    }

    return weather;
  }
}
