import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/services/weather_service.dart';
import 'package:minimal_weather_app/models/weather_models.dart';

class WeatherPage extends StatefulWidget{

  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
  }
  class _WeatherPageState extends State<WeatherPage>{
    
    final _weatherService = WeatherService('a1bd2634a9cffc55db09439f1a000dfd');
    Weather? _weather;


    _fetchWeather() async {
      String cityName = await _weatherService.getCurrentCity();

      try {
        final weather = await _weatherService.getWeather(cityName);
        setState((){
          _weather = weather; 
        });
    
      } 
      catch(e){
        print(e);
      }
    }
    
    String getWeatherAnimation(String? mainCondition){

      if(mainCondition == null) return 'assets/sunny.json';

      switch (mainCondition.toLowerCase()){
        case 'clouds' : 
        case 'mist' :
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'fog':
           return 'assets/cloud.json';
        case 'rain':
        case 'drizzle':
        case 'shower rain':
           return 'assets/rain.json';
        case 'thunderstorm':
           return 'assets/thunder.json';
        case 'clear':
           return 'assets/sunny.json';
        default:
           return 'assets/sunny.json';
      } 
    }
    
    
    @override
    void initState(){
      super.initState();
      _fetchWeather();
    }
    Widget build(BuildContext context){
      return Scaffold(
        backgroundColor:Colors.grey[800],

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_weather?.cityName ?? "loading city.."),

              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

              Text('${_weather?.temperature.round()}°C'),

              Text(_weather?.mainCondition ?? "")
            ],
          ),
        ),



      );
    }

}