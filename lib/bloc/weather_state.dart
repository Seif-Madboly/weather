part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}
class WeatherLoading extends WeatherState{}
class WeatherSuccess extends WeatherState{

}
class WeatherError extends WeatherState{}
