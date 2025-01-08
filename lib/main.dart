import 'package:animations/UI/3d_drawer.dart';
import 'package:animations/UI/animated_prompt.dart';
import 'package:animations/UI/hero_animation/hero_animation.dart';
import 'package:animations/UI/hexagon.dart';
import 'package:animations/UI/home_screen.dart';
import 'package:animations/UI/implicit_animation.dart';
import 'package:animations/UI/polygon_custompaint.dart';
import 'package:animations/UI/rotating_cube.dart';
import 'package:animations/UI/tween_circle.dart';
import 'package:flutter/material.dart';

import 'UI/card_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData(
          brightness: Brightness.dark
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
    );
  }
}
