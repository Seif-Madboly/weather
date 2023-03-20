// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/model/weather_Model.dart';
import 'package:weather/pages/search_page.dart';

class HomePage extends StatelessWidget {
  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SearchScreen();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.search))
          ],
          title: const Text("Weather App"),
        ),
        body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WeatherSuccess) {
              weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
              return SuccessBody(weatherData: weatherData,);
            } else if (state is WeatherError) {
              return Center(child: Text("Sorry, but Something Went Wrong!"));
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "There is no weather 😔 start",
                      style: TextStyle(fontSize: 30),
                    ),
                    const Text(
                      "Searching Now 🔍",
                      style: TextStyle(fontSize: 30),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }


}

class SuccessBody extends StatelessWidget {

  final WeatherModel? weatherData;

  const SuccessBody({super.key, this.weatherData});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            weatherData!.getThemeColor(),
            weatherData!.getThemeColor()[300]!,
            weatherData!.getThemeColor()[100]!,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 3),
          Text(
            BlocProvider.of<WeatherCubit>(context).cityName!,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Updated at: ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()} - ${weatherData!.date.day.toString()}/${weatherData!.date.month.toString()}/${weatherData!.date.year.toString()}",
            style: TextStyle(fontSize: 22),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(weatherData!.getImage()),
              Text(
                weatherData!.temp.toInt().toString(),
                style: TextStyle(fontSize: 30),
              ),
              Column(
                children: [
                  Text(
                    "maxTemp: ${weatherData!.maxTemp.toInt()}",
                  ),
                  Text("minTemp: ${weatherData!.minTemp.toInt()}"),
                ],
              )
            ],
          ),
          Spacer(),
          Text(
            weatherData!.weatherStateName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Spacer(flex: 5),
        ],
      ),
    );  }
}