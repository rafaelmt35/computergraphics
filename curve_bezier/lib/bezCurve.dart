// ignore_for_file: file_names

import 'dart:math';
import 'pointsClass.dart';
import 'package:flutter/material.dart';

class BezierCurve {
  List<Point> points;

  BezierCurve(this.points);

  //draw points
  List<Point> makeBezierCurve() {
    final curvePoints = <Point>[];
    for (int i = 0; i < 900; i++) {
      final t = i / 900;
      final point = bezierCurvePoints(t);
      curvePoints.add(point);
    }
    return curvePoints;
  }

  //Bernstein polynomial // (binomialcoeff) x^v (1-x)^n-v // i = n // v= 0,...,n
  double bezierCoefficient(int i, int n, double t) {
    return binomialCoeff(i, n) * pow(t, i) * pow((1 - t), (n - i));
  }

  // n!/k!(n-k)!
  double binomialCoeff(int i, int n) {
    final a = factorial(n);
    final b = factorial(i) * factorial(n - i);
    return (a / b);
  }

  //bernstein polynomial -> p1 * bernsPolynomial -> +=result
  Point bezierCurvePoints(double t) {
    var res = Point(0, 0);
    for (int i = 0; i <= points.length - 1; i++) {
      final a = bezierCoefficient(i, points.length - 1, t);
      final b = points[i].multiply(a);
      res = res.sum(b);
    }
    return res;
  }

  int factorial(int n) {
    if (n == 0) {
      return 1;
    }
    int result = 1;
    for (int i = 1; i <= n; i++) {
      result *= i;
    }
    return result;
  }

//DRAW BEZIER CURVE POINTS
  void paint(Canvas canvas, Paint paint) {
    final bezierCurvePoints = makeBezierCurve();
    for (final point in bezierCurvePoints) {
      canvas.drawCircle(Offset(point.x, point.y), 1.0, paint);
    }
  }
}
