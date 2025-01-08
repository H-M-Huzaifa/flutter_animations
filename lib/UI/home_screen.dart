import 'package:animations/UI/3d_drawer.dart';
import 'package:animations/UI/animated_prompt.dart';
import 'package:animations/UI/card_animation.dart';
import 'package:animations/UI/half_cirlces.dart';
import 'package:animations/UI/hero_animation/hero_animation.dart';
import 'package:animations/UI/hexagon.dart';
import 'package:animations/UI/implicit_animation.dart';
import 'package:animations/UI/polygon_custompaint.dart';
import 'package:animations/UI/rotating_cube.dart';
import 'package:animations/UI/tween_circle.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define a list of routes (screen names and their corresponding widgets)
  final List<Map<String, dynamic>> mylist = [
    {
      "name": "Card Animation",
      "route": const CardAnimation()
    },
    {
      "name": "Half Circles",
      "route": const HalfCirlces()
    },
    {
      "name": "Rotating Cube",
      "route": const RotatingCube()
    },
    {
      "name": "Hero Animation",
      "route": const HeroAnimation()
    },
    {
      "name": "Implicit Animation",
      "route": const ImplicitAnimation()
    },
    {
      "name": "Tween Circle",
      "route": const TweenCircle()
    },
    {
      "name": "Hexagon",
      "route": const Hexagon()
    },
    {
      "name": "3D Drawer",
      "route": const Drawer3D()
    },
    {
      "name": "Animated Prompt",
      "route": const AnimatedPrompt(),
    },
    {
      "name": "Polygon CustomPaint",
      "route": const PolygonCustompaint(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animations"),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: mylist.length, // Use the length of your list
        itemBuilder: (context, index) {
          final item = mylist[index]; // Get the current item
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item['route']),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8.0), // Add some margin for spacing
              padding: const EdgeInsets.all(16.0), // Add padding for text
              decoration: BoxDecoration(
                color: Colors.blue, // Customize container appearance
                borderRadius: BorderRadius.circular(12.0),
              ),
              alignment: Alignment.center,
              child: Text(
                item['name'], // Display the screen name
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          );
        },
      ),
    );
  }
}