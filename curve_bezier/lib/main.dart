// ignore_for_file: library_private_types_in_public_api

import 'package:curve_bezier/pointsClass.dart';
import 'package:curve_bezier/splineCurve.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BezierSplineApp(),
    );
  }
}

class BezierSplineApp extends StatefulWidget {
  const BezierSplineApp({super.key});

  @override
  _BezierSplineAppState createState() => _BezierSplineAppState();
}

class _BezierSplineAppState extends State<BezierSplineApp> {
  List<Offset> controlPoints = [];
  List<Point> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bezier Spline App'),
      ),
      body: Center(
        child: GestureDetector(
          onTapDown: (details) {
            setState(() {
              controlPoints.add(details.localPosition);
              points = controlPoints
                  .map((offset) => Point(offset.dx, offset.dy))
                  .toList();
            });
          },
          child: CustomPaint(
            size: const Size(500, 500),
            painter: BezierSplinePainter(
                controlPoints: controlPoints, points: points),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            controlPoints.clear();
            points.clear();
          });
        },
        child: const Icon(Icons.clear),
      ),
    );
  }
}

class BezierSplinePainter extends CustomPainter {
  final List<Offset> controlPoints;
  final List<Point> points;

  BezierSplinePainter({required this.controlPoints, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    for (final point in controlPoints) {
      canvas.drawCircle(point, 5.0, paint);
    }

    if (points.length >= 4) {
      final linePaint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      final dotsConnectPaint = Paint()
        ..color = Colors.green
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      // Connect the dots with lines
      for (int i = 0; i < controlPoints.length - 1; i++) {
        canvas.drawLine(
            controlPoints[i], controlPoints[i + 1], dotsConnectPaint);
      }

      // Create a Spline object with the points and paint
      final spline = Spline(points.cast<Point>());
      spline.paint(canvas, linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
