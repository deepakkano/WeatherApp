import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';

abstract class WeatherState extends Equatable {}

class InitalWeatherState extends WeatherState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoadingWeatherState extends WeatherState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoadedWeatherState extends WeatherState {
  final Weather weather;
  LoadedWeatherState(this.weather);
  @override
  List<Object?> get props => [weather];
}

class LoadedForcastWeatherState extends WeatherState{

final List<Weather> weather;
LoadedForcastWeatherState(this.weather);


  @override
  // TODO: implement props
  List<Object?> get props => [weather];

}



class ErrorWeatherState extends WeatherState {
  @override
  
  List<Object?> get props => throw UnimplementedError();
}
