import 'package:flutter/material.dart';
import 'dart:math' as math;

class TweenCircle extends StatefulWidget {
  const TweenCircle({super.key});

  @override
  State<TweenCircle> createState() => _TweenCircleState();
}

class _TweenCircleState extends State<TweenCircle> {
  var _color = getRandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tween Circle"),
        centerTitle: true,
      ),
      body: Center(
        child: ClipPath(
          clipper: CircleClipper(),
          child: TweenAnimationBuilder(
            duration: Duration(milliseconds:800 ),
            tween: ColorTween(
                begin: getRandomColor(),
                end: _color
            ),onEnd: () {
              setState(() {
                _color=getRandomColor();
              });
            },
            builder: (context, Color? color, child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  color: Colors.red,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

//method for random color
Color getRandomColor() => Color(0xFF000000 + math.Random().nextInt(0xFFFFFF));

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);

    path.addOval(rect);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
