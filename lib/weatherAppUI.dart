import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapplication/bloc/bloc.dart';
import 'package:weatherapplication/bloc/bloc_event.dart';
import 'package:weatherapplication/bloc/bloc_state.dart';

class Weatherappui extends StatefulWidget {
  const Weatherappui({super.key});

  @override
  State<Weatherappui> createState() => _WeatherappuiState();
}

class _WeatherappuiState extends State<Weatherappui> {
  @override
  Widget getGreeting(DateTime time) {
    int hour = time.hour;

    if (hour >= 0 && hour < 12) {
      return Text(
        'Good Morning',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
      );
    } else if (hour >= 12 && hour < 19) {
      return Text(
        'Good AfterNoon',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
      );
    } else {
      return Text(
        'Good Night',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
      );
    }
  }

  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset(
          'assets/images/1.png',
          width: 150,
          height: 150,
        );
      case >= 300 && < 400:
        return Image.asset(
          'assets/images/2.png',
          width: 250,
          height: 250,
        );
      case >= 500 && < 600:
        return Image.asset(
          'assets/images/3.png',
          width: 250,
          height: 250,
        );
      case >= 600 && < 700:
        return Image.asset(
          'assets/images/4.png',
          width: 250,
          height: 250,
        );
      case >= 700 && < 800:
        return Image.asset(
          'assets/images/5.png',
          width: 250,
          height: 250,
        );
      case == 800:
        return Image.asset(
          'assets/images/6.png',
          width: 250,
          height: 250,
        );
      case > 800 && <= 804:
        return Image.asset(
          'assets/images/7.png',
          width: 250,
          height: 250,
        );
      default:
        return Image.asset(
          'assets/images/7.png',
          width: 150,
          height: 150,
        );
    }
  }  final TextEditingController _searchController = TextEditingController();
 bool _showSearch = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _showSearch = !_showSearch;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
          resizeToAvoidBottomInset: false,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: _showSearch
            ? Padding(
              padding: const EdgeInsets.only(left: 40,right: 40),
              child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search city...',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      BlocProvider.of<BlocWeather>(context).add(FetchWeatherByCity(value));
                      _toggleSearch();
                    }
                  },
                ),
            )
            : Text(""),
        actions: [
          if (_showSearch)
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  if (_searchController.text.isNotEmpty) {
                    BlocProvider.of<BlocWeather>(context).add(FetchWeatherByCity(_searchController.text));
                    _toggleSearch();
                  }
                },
              ),
            ),
        ],
      ),
        
        body: Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              40,
              0,
              40,
              20,
            ),
            child:
                BlocBuilder<BlocWeather, WeatherState>(builder: (context, state) {
              if (state is LoadedWeatherState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(3, -0.3),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.deepPurple),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-3, -0.3),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFF673AB7)),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, -1.2),
                        child: Container(
                          height: 300,
                          width: 600,
                          decoration:
                              const BoxDecoration(color: Color(0xFFFFAB40)),
                        ),
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                        child: Container(
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             GestureDetector(
                    onTap: _toggleSearch,
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red),
                        Text(
                          '${state.weather.areaName}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                            ),
                            getGreeting(DateTime.now()),
                            Align(
                              alignment: Alignment.center,
                              child: getWeatherIcon(
                                  state.weather.weatherConditionCode!),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    '${state.weather.temperature!.celsius!.round()}°C',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 45),
                                  ),
                                  Text(
                                    '${state.weather.weatherMain!.toUpperCase()}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 25),
                                  ),
                                  Text(
                                    DateFormat('EEEE dd •')
                                        .add_jm()
                                        .format(state.weather.date!),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/11.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sunrise',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunrise!),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/12.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sunset',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunset!),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/16.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Wind',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          "${state.weather.windSpeed!.round()}kts",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/15.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Humidity',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          "${state.weather.humidity!.round()}g / m³",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
          
          
           Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
          
          
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/13.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Temp Max',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          "${state.weather.tempMax!.celsius!.round()} °C",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/14.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Temp min',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          "${state.weather.tempMin!.celsius!.round()} °C",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
              return Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ));
  }
}
