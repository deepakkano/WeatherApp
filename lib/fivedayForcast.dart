import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapplication/bloc/bloc.dart';
import 'package:weatherapplication/bloc/bloc_state.dart';

class Fivedayforcast extends StatefulWidget {
  const Fivedayforcast({super.key});

  @override
  State<Fivedayforcast> createState() => _FivedayforcastState();
}

class _FivedayforcastState extends State<Fivedayforcast> {
  String getDayOfWeek(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5-Day Forecast'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<BlocWeather, WeatherState>(
          builder: (context, state) {
            if (state is LoadingWeatherState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LoadedForcastWeatherState) {
              return ListView.builder(
                itemCount: state.weather.length,
                itemBuilder: (context, index) {
                  final weather = state.weather[index];
                  return Card(
                    child: ListTile(
                      title: Text(getDayOfWeek(weather.date!)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Temp: ${weather.temperature!.celsius!.round()}°C'),
                          Text('Condition: ${weather.weatherMain}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is ErrorWeatherState) {
              return Center(child: Text('Failed to load forecast data'));
            } else {
              return Center(child: Text('Unexpected state'));
            }
          },
        ),
      ),
    );

  }
}