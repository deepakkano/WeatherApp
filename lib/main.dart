import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weatherapplication/bloc/bloc.dart';
import 'package:weatherapplication/bloc/bloc_event.dart';
import 'package:weatherapplication/weatherAppUI.dart';
import 'package:weatherapplication/Api_code/current_location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final getCurrentPositionWeather pW = getCurrentPositionWeather();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
      future: pW.determinePosition(),
      builder: (context, snap) {
        if (snap.hasData) {
          return BlocProvider<BlocWeather>(
            create: (context) => BlocWeather()..add(FetchCurrentWeather(
              snap.data as Position
            )),

            child: Weatherappui(),
          );
        } else {
          return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/location.gif",width: 150,height: 150,),
                    LoadingAnimationWidget.flickr(
      leftDotColor: const Color(0xFF1A1A3F),
          rightDotColor: const Color(0xFFEA3799),
          size: 50,
      ),
                  ],
                ),
              ),
            );
        }
      },
    ),
    );
  }
}
