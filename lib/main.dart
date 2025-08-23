import 'package:flutter/material.dart';
import 'package:my_whistle/screens/stage1_basic.dart';
import 'package:my_whistle/screens/stage2_multiple.dart';
import 'package:my_whistle/screens/stage3_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Comment out the selected stage and uncomment the desired stage you wish to view
      home: const Stage1Basic(),
      // home: const Stage2Multiple(),
      // home: const Stage3Slider(),
    );
  }
}