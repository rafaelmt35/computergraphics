// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:math';

class Point {
  double x;
  double y;

  Point(this.x, this.y);

  //multiply points
  Point multiply(double num) {
    return Point(x * num, y * num);
  }

  //sum points
  Point sum(Point point) {
    return Point(x + point.x, y + point.y);
  }

  //distance
  Point diff(Point point) {
    return Point(x - point.x, y - point.y);
  }

  //change offset (x.old+new offset)
  Point changeOffset(Point offset) {
    return Point(x + offset.x, y + offset.y);
  }

  //DIVIDE BY 2
  Point makeMiddlePoint(Point point, [double n = 0.5]) {
    final x = this.x + (point.x - this.x) * n;
    final y = this.y + (point.y - this.y) * n;

    return Point(x, y);
  }

  //FIND DISTANCE BETWEEN POINTS pythagoras
  double distance(Point point) {
    final xDistance = (x - point.x).abs();
    final yDistance = (y - point.y).abs();
    return sqrt((xDistance * xDistance) + (yDistance * yDistance));
  }

  void paint(Canvas canvas, {Color color = Colors.blue}) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(x, y), 1.0, paint);
  }
}
