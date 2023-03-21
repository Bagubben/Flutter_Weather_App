import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
        ),
        body: Column(
          children: [
            Image.asset('images/turning_torso_sun.jpg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
            )
          ]
        ),
        ),
    );
  }
}
