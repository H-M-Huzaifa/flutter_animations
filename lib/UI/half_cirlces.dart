import 'dart:math' show pi;
import 'package:animations/UI/rotating_cube.dart';
import 'package:flutter/material.dart';

class HalfCirlces extends StatefulWidget {
  const HalfCirlces({super.key});

  @override
  State<HalfCirlces> createState() => _HalfCirlcesState();
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

enum CircleSides { left, right }

extension ToPath on CircleSides {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;
    switch (this) {
      case CircleSides.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSides.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width / 2, size.height / 2),
        clockwise: clockwise);
    path.close();
    return path;
  }
}

class HalfCirclesClipper extends CustomClipper<Path> {
  final CircleSides side;

  HalfCirclesClipper({required this.side});

  @override
  getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) => true;
}

class _HalfCirlcesState extends State<HalfCirlces>
    with TickerProviderStateMixin {
  late AnimationController _counterCLockwiseRotationController;
  late Animation<double> _counterCLockwiseRotationAnimation;

  late AnimationController _flipAnimationController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _counterCLockwiseRotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _counterCLockwiseRotationAnimation = Tween<double>(begin: 0, end: -(pi / 2))
        .animate(CurvedAnimation(
            parent: _counterCLockwiseRotationController,
            curve: Curves.bounceOut));

    //flip animation
    _flipAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _flipAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(CurvedAnimation(
        parent: _flipAnimationController, curve: Curves.bounceOut));

    //status listener
    _counterCLockwiseRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
          begin: _flipAnimation.value,
          end: _flipAnimation.value + pi,
        ).animate(CurvedAnimation(
            parent: _flipAnimationController, curve: Curves.bounceOut));


        //reset flip controller and start animation
        _flipAnimationController
          ..reset()
          ..forward();
      }
    });

    _flipAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _counterCLockwiseRotationAnimation = Tween<double>(
            begin: _counterCLockwiseRotationAnimation.value,
            end: _counterCLockwiseRotationAnimation.value + -(pi / 2))
            .animate(CurvedAnimation(
            parent: _counterCLockwiseRotationController,
            curve: Curves.bounceOut));

        _counterCLockwiseRotationController
          ..reset()
          ..forward();
      }
    }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _counterCLockwiseRotationController.dispose();
    _flipAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _counterCLockwiseRotationController
      ..reset()
      ..forward.delayed(Duration(seconds: 1));

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: AnimatedBuilder(
          animation: _counterCLockwiseRotationController,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateZ(_counterCLockwiseRotationAnimation.value),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RotatingCube(),));

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _flipAnimationController,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.identity()
                            ..rotateY(_flipAnimation.value),
                          alignment: Alignment.centerRight,
                          child: ClipPath(
                            clipper: HalfCirclesClipper(side: CircleSides.left),
                            child: Container(
                              color: Colors.white,
                              width: 200,
                              height: 200,
                            ),
                          ),
                        );
                      },
                    ),

                    AnimatedBuilder(
                      animation: _flipAnimationController,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.identity()
                            ..rotateY(_flipAnimation.value),
                          alignment: Alignment.centerLeft,
                          child: ClipPath(
                            clipper: HalfCirclesClipper(side: CircleSides.right),
                            child: Container(
                              color: Color(0xff004904),
                              width: 200,
                              height: 200,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        )),
      ),
    );
  }
}
