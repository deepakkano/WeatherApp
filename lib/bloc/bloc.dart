import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weatherapplication/Api_code/Api_call.dart';
import 'package:weatherapplication/bloc/bloc_event.dart';
import 'package:weatherapplication/bloc/bloc_state.dart';

class BlocWeather extends Bloc<WeatherEvent, WeatherState> {
  BlocWeather() : super(InitalWeatherState()) {
   
WeatherFactory weatherFactory =
        WeatherFactory(Api_key, language: Language.ENGLISH);
    on<FetchCurrentWeather>((event, emit) async {
      emit(LoadingWeatherState());
 
      try {
        Weather weathercurrent = await weatherFactory.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
        // print(weathercurrent);

        emit(LoadedWeatherState(weathercurrent));
      } catch (e) {
        emit(ErrorWeatherState());
      }
    });

 on<FetchWeatherByCity>((event, emit) async {
      emit(LoadingWeatherState());

      try {
        Weather weather = await weatherFactory.currentWeatherByCityName(event.cityName);
        print(weather);

        emit(LoadedWeatherState(weather));
      } catch (e) {
        emit(ErrorWeatherState());
      }
    });

    on<FetchoforcastWeather>((event, emit) async {
      emit(LoadingWeatherState());
      try {
        WeatherFactory weatherFactory = WeatherFactory(Api_key, language: Language.ENGLISH);
        List<Weather> forecast = await weatherFactory.fiveDayForecastByLocation(
          event.position.latitude,
          event.position.longitude,
        );
        emit(LoadedForcastWeatherState(forecast));
      } catch (e) {
        emit(ErrorWeatherState());
      }
    });

  }
}
