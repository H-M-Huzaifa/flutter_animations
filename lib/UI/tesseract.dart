import 'package:flutter/material.dart';
import 'dart:math' ;


class TesseractApp extends StatelessWidget {
  const TesseractApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const TesseractVisualizer(),
      ),
    );
  }
}

class TesseractVisualizer extends StatefulWidget {
  const TesseractVisualizer({Key? key}) : super(key: key);

  @override
  _TesseractVisualizerState createState() => _TesseractVisualizerState();
}

class _TesseractVisualizerState extends State<TesseractVisualizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: TesseractPainter(_controller.value),
          child: Container(),
        );
      },
    );
  }
}

class TesseractPainter extends CustomPainter {
  final double animationValue;

  TesseractPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double scale = min(size.width, size.height) / 3;

    // Vertices of a hypercube projected into 2D
    final List<Offset> vertices = _projectedTesseractVertices(scale);

    // Draw connections
    final paint = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Transform vertices based on the animation value (rotation)
    final rotatedVertices = vertices.map((v) {
      return _rotatePoint(v, center, animationValue * 2 * pi);
    }).toList();

    // Draw edges of the tesseract
    final edges = _getTesseractEdges();
    for (var edge in edges) {
      canvas.drawLine(rotatedVertices[edge[0]], rotatedVertices[edge[1]], paint);
    }
  }

  List<Offset> _projectedTesseractVertices(double scale) {
    // Simplified vertex list for a 4D hypercube (tesseract) projected in 2D.
    final List<List<double>> vertices4D = [
      [-1, -1, -1, -1],
      [1, -1, -1, -1],
      [1, 1, -1, -1],
      [-1, 1, -1, -1],
      [-1, -1, 1, -1],
      [1, -1, 1, -1],
      [1, 1, 1, -1],
      [-1, 1, 1, -1],
      [-1, -1, -1, 1],
      [1, -1, -1, 1],
      [1, 1, -1, 1],
      [-1, 1, -1, 1],
      [-1, -1, 1, 1],
      [1, -1, 1, 1],
      [1, 1, 1, 1],
      [-1, 1, 1, 1],
    ];

    return vertices4D.map((vertex) {
      final x = vertex[0] + vertex[3];
      final y = vertex[1] + vertex[2];
      return Offset(x * scale, y * scale);
    }).toList();
  }

  Offset _rotatePoint(Offset point, Offset center, double angle) {
    final double cosTheta = cos(angle);
    final double sinTheta = sin(angle);

    final double dx = point.dx - center.dx;
    final double dy = point.dy - center.dy;

    return Offset(
      cosTheta * dx - sinTheta * dy + center.dx,
      sinTheta * dx + cosTheta * dy + center.dy,
    );
  }

  List<List<int>> _getTesseractEdges() {
    return [
      [0, 1], [1, 2], [2, 3], [3, 0], // First cube
      [4, 5], [5, 6], [6, 7], [7, 4], // Second cube
      [0, 4], [1, 5], [2, 6], [3, 7], // Connections zbetween cubes
      [8, 9], [9, 10], [10, 11], [11, 8], // Third cube
      [12, 13], [13, 14], [14, 15], [15, 12], // Fourth cube
      [8, 12], [9, 13], [10, 14], [11, 15], // Connections between cubes
      [0, 8], [1, 9], [2, 10], [3, 11], [4, 12], [5, 13], [6, 14], [7, 15] // Connecting first and third
    ];
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}