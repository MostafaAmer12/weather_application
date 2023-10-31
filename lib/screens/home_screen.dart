import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/cubit/weather_cubit.dart';
import 'package:weather_application/cubit/weather_states.dart';
import 'package:weather_application/screens/search_screen.dart';

import '../models/weather_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              BlocProvider.of<WeatherCubit>(context).weatherModel == null
                  ? Colors.blue
                  : BlocProvider.of<WeatherCubit>(context)
                      .weatherModel!
                      .getThemeColor(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchScreen();
                  }));
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ],
          title: const Text(
            'Weather',
          ),
        ),
        body: BlocBuilder<WeatherCubit, weatherStates>(
          builder: (context, state) {
            if (state is LoadingWeatherState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SuccessWeatherState) {
              weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    weatherData!.getThemeColor(),
                    weatherData!.getThemeColor()[300]!,
                    weatherData!.getThemeColor()[100]!,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 4,
                      ),
                      Text(
                        BlocProvider.of<WeatherCubit>(context).cityName!,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(weatherData!.getImage()),
                          Text(
                            '${weatherData!.main.temp.toInt()}',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                'MaxTemp: ${weatherData!.main.tempMax.toInt()}',
                              ),
                              Text(
                                'MinTemp: ${weatherData!.main.tempMin.toInt()}',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        weatherData!.weatherStateName,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(
                        flex: 6,
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is FailureWeatherState) {
              return const Center(
                child: Text('Searching Failure'),
              );
            } else {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'There is no Weather 😔',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Searching Now 🔍',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
