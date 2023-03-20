// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
 import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/services/weather_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
      BlocProvider(
      create: (context) {
        return WeatherCubit(WeatherService());
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: BlocProvider.of<WeatherCubit>(context).weatherModel == null
            ? Colors.blue
            : BlocProvider.of<WeatherCubit>(context)
                .weatherModel!
                .getThemeColor(),
      ),
      home: HomePage(),
    );
  }
}
