import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class Hexagon extends StatefulWidget {
  const Hexagon({super.key});

  @override
  State<Hexagon> createState() => _HexagonState();
}

class _HexagonState extends State<Hexagon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: Size(200, 200),
          painter:HexagonShape(0.14),
        ),
      ),
    );
  }
}

class HexagonShape extends CustomPainter {
  final double progress; // Progress value from 0.0 to 1.0

  HexagonShape(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final Paint progressPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    final double radius = size.width / 2; // Radius of the hexagon

    // Rotate the canvas by -30 degrees to align one corner vertically
    canvas.translate(size.width / 2, size.height / 2); // Move the origin to the center
    canvas.rotate(-pi / 6); // Rotate the canvas

    // Path for the hexagon
    Path hexagonPath = Path();
    for (int i = 0; i < 6; i++) {
      double angle = (60 * i) * (pi / 180.0);
      double x = radius * cos(angle);
      double y = radius * sin(angle);

      if (i == 0) {
        hexagonPath.moveTo(x, y);
      } else {
        hexagonPath.lineTo(x, y);
      }
    }
    hexagonPath.close();

    // Draw the hexagon
    canvas.drawPath(hexagonPath, fillPaint);

    // Path for the progress indicator
    Path progressPath = Path();
    double totalLength = 6 * radius; // Approximation: hexagon perimeter
    double currentLength = progress * totalLength;

    double accumulatedLength = 0.0;
    Offset? startPoint;

    for (int i = 0; i < 6; i++) {
      double angle = (60 * i) * (pi / 180.0);
      double nextAngle = (60 * (i + 1)) * (pi / 180.0);

      Offset start = Offset(radius * cos(angle), radius * sin(angle));
      Offset end = Offset(radius * cos(nextAngle), radius * sin(nextAngle));

      double edgeLength = (end - start).distance;

      if (accumulatedLength + edgeLength > currentLength) {
        // Partially draw this edge
        double remainingLength = currentLength - accumulatedLength;
        double t = remainingLength / edgeLength; // Fraction of the edge to draw
        Offset partialEnd = Offset.lerp(start, end, t)!;

        if (startPoint == null) {
          progressPath.moveTo(start.dx, start.dy);
        }
        progressPath.lineTo(partialEnd.dx, partialEnd.dy);
        break;
      } else {
        if (startPoint == null) {
          progressPath.moveTo(start.dx, start.dy);
        }
        progressPath.lineTo(end.dx, end.dy);
        accumulatedLength += edgeLength;
      }
    }

    // Draw the progress path
    canvas.drawPath(progressPath, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

