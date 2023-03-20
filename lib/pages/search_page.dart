import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  String? cityName;

  SearchScreen({super.key});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search a City",
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              cityName = data;

              BlocProvider.of<WeatherCubit>(context)
                  .getWeather(cityName: cityName!);

              BlocProvider.of<WeatherCubit>(context)
              .cityName = cityName!;

              Navigator.pop(context);
            },
            decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                label: Text("Search"),
                hintText: "Enter a City",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search)),
          ),
        ),
      ),
    );
  }
}
