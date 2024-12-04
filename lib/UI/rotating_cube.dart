import 'dart:math';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:flutter/material.dart';

const WidthandHeight = 100.0;

class RotatingCube extends StatefulWidget {
  const RotatingCube({super.key});

  @override
  State<RotatingCube> createState() => _RotatingCubeState();
}

class _RotatingCubeState extends State<RotatingCube>
    with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;

  late Tween<double> _animation;

  @override
  void initState() {
    _xController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));

    _yController =
        AnimationController(vsync: this, duration: Duration(seconds: 30));

    _zController =
        AnimationController(vsync: this, duration: Duration(seconds: 40));

    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );
    super.initState();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation:
                  Listenable.merge([_xController, _yController, _zController]),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_animation.evaluate(_xController))
                    ..rotateY(_animation.evaluate(_yController))
                    ..rotateZ(_animation.evaluate(_zController)),
                  child: Stack(
                    children: [

                      //front side
                      Center(
                        child: Container(
                          color: Colors.red,
                          width: WidthandHeight,
                          height: WidthandHeight,
                        ),
                      ),

                      //back side
                      Center(
                        child: Transform(
                          alignment: Alignment.center,
                         transform: Matrix4.identity()..translate(
                             Vector3(0,0,-WidthandHeight)),
                          child: Container(
                            color: Colors.green,
                            width: WidthandHeight,
                            height: WidthandHeight,
                          ),
                        ),
                      ),

                      //left side
                      Center(
                        child: Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()..rotateY(pi/2.0),
                          child: Container(
                            color: Colors.blue,
                            width: WidthandHeight,
                            height: WidthandHeight,
                          ),
                        ),
                      ),

                      //right side
                      Center(
                        child: Transform(
                          alignment: Alignment.centerRight,
                          transform: Matrix4.identity()..rotateY(pi/-2.0),
                          child: Container(
                            color: Colors.yellow,
                            width: WidthandHeight,
                            height: WidthandHeight,
                          ),
                        ),
                      ),

                      //top side
                      Center(
                        child: Transform(
                          alignment: Alignment.topCenter,
                          transform: Matrix4.identity()..rotateX(pi/-2.0),
                          child: Container(
                            color: Colors.orange,
                            width: WidthandHeight,
                            height: WidthandHeight,
                          ),
                        ),
                      ),

                      //bottom side
                      Center(
                        child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()..rotateX(pi/2.0),
                          child: Container(
                            color: Colors.indigoAccent,
                            width: WidthandHeight,
                            height: WidthandHeight,
                          ),
                        ),
                      ),


                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

