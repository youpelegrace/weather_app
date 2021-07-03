// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double temp = 0;
  String description = "";
  String currently = "";
  // ignore: prefer_typing_uninitialized_variables
  int humidity = 0;
  double windSpeed = 0;

  Future getWeather() async {
//     var url = Uri.parse('https://example.com/whatsit/create');
// var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    var url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=Nigeria&appid=cdc7ebb6560855618f6ed277c61ededd&units=metric');
    http.Response response = await http.get(url);

    var results = jsonDecode(response.body);
    setState(() {
      temp = results["main"]["temp"];
      description = results["weather"][0]["description"];
      currently = results["weather"][0]["main"];
      humidity = results["main"]["humidity"];
      windSpeed = results["wind"]["speed"];
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in Nigeria",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: Text("Temperature"),
                  trailing: Text(
                      temp != null ? temp.toString() + "\u00B0" : "Loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text("Weather"),
                  trailing: Text(
                      description != null ? description.toString() : "Loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.sun),
                  title: Text("Humidity"),
                  trailing:
                      Text(humidity != null ? humidity.toString() : "Loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text("Wind"),
                  trailing: Text(
                      windSpeed != null ? windSpeed.toString() : "Loading"),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
