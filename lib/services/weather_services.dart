// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/model/weather_Model.dart';

class WeatherService {
  String baseUrl = "http://api.weatherapi.com/v1";
  String apiKey = "d514bbb89fa54971ae6161215231703";

  Future<WeatherModel> getWeather({required String cityName}) async {
    Uri url = Uri.parse(
      "$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7",
    );
    http.Response response = await http.get(url);

    if(response.statusCode == 400) {
      var getData = jsonDecode(response.body);
      throw Exception(getData['error']['message']);
    }

    Map<String, dynamic> getData = jsonDecode(response.body);

    WeatherModel weather = WeatherModel.fromJson(getData);

    return weather;

    }
  }



