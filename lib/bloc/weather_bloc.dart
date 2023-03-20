import 'package:bloc/bloc.dart';
import 'package:weather/model/weather_Model.dart';
import 'package:weather/services/weather_services.dart';

// part 'weather_event.dart';
part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherService) : super(WeatherInitial());
    WeatherModel? weatherModel;
    WeatherService weatherService;
    String? cityName;
    void getWeather({required String cityName})async{
      emit(WeatherLoading());
      try{
       weatherModel =await weatherService.getWeather(cityName: cityName);
      emit(WeatherSuccess());
      }on Exception catch (e){
        emit(WeatherError());
      }
    }

  }

