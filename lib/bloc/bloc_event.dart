import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

 abstract class WeatherEvent extends Equatable{

}
class FetchCurrentWeather extends WeatherEvent {
  final Position position;
  FetchCurrentWeather(this.position);

  @override
  // TODO: implement props
  List<Object?> get props => [position];
  
 
}


class FetchoforcastWeather extends WeatherEvent{
  final Position position;
  FetchoforcastWeather(this.position);
  
  @override
  // TODO: implement props
  List<Object?> get props => [position];

}



class FetchWeatherByCity extends WeatherEvent {
  final String cityName;
  FetchWeatherByCity(this.cityName);
  
  @override
  // TODO: implement props
  List<Object?> get props => [cityName];
}