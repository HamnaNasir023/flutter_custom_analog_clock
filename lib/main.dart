import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_custom_analog_clock/clock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _currentTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(() {
            
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomPaint(
              painter: ClockPainter(
                  now: DateTime.now(),
                  circleColor1: const Color.fromARGB(255, 87, 41, 24),
                  circleColor2: const Color.fromARGB(255, 251, 253, 255),
                  circleColor3: const Color.fromARGB(255, 123, 70, 51),
                  circleColor4: const Color.fromARGB(255, 251, 253, 255),
                  circleColor5: const Color.fromARGB(255, 87, 41, 24),
                  minutesNeedleColor: Colors.black,
                  hoursNeedleColor: Colors.black,
                  secondsNeedleColor: const Color.fromARGB(255, 87, 41, 24),
                  borderColor: const Color.fromARGB(255, 67, 39, 29)),
              size: const Size(250, 250),
            )
          ],
        ),
      ),
    );
  }
}
