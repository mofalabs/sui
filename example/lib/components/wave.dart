
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Wave extends StatelessWidget {
  const Wave({ Key? key }) : super(key: key);

  static const _colors = [
      Color.fromRGBO(84, 150, 229, 1),
      Color(0xFF00BBF9)
  ];

  static const _durations = [
      5000,
      4000,
  ];

  static const _heightPercentages = [
      0.65,
      0.66,
  ];

  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                children: [
                  Text("Sui Dart SDK", style: TextStyle(fontSize: 35)),
                  SizedBox(height: 20),
                  Text("A cross-platform Sui SDK for Mobile, Web and Desktop", style: TextStyle(fontSize: 28), textAlign: TextAlign.center)
                ],
              )
            ),
          ),
          Expanded(
            flex: 1,
            child: WaveWidget(
              config: CustomConfig(
                  colors: _colors,
                  durations: _durations,
                  heightPercentages: _heightPercentages,
              ),
              size: Size(double.infinity, double.infinity),
              waveAmplitude: 0,
            ),
          ),
        ],
      ),
    );
  }
}