import 'package:clima/utilities/api_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clima/services/location.dart';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  String apiKey = APIKey().getKey();

 void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }
  
  void getData() async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=$apiKey'
    );
    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);

      double temperature = decodedData['main']['temp'];
      int condition = decodedData['weather'][0]['id'];
      String cityName = decodedData['name'];

      print(temperature);
      print(condition);
      print(cityName);

    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }


  @override
  Widget build(BuildContext context) {
   getData();
    return SafeArea(
      child: Scaffold(
        body: Container(
        )
      ),
    );
  }
}
