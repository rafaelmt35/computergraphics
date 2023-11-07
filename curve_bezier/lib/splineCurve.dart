// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:ui';
import 'pointsClass.dart';
import 'bezCurve.dart';

class Spline {
  List<Point> points;

  Spline(this.points);

  //find middle point
  List<Point> findMidPoint() {
    final middlePoints = <Point>[];

    for (int i = 0; i < points.length - 1; i++) {
      final middlePoint = points[i].makeMiddlePoint(points[i + 1]);
      middlePoints.add(middlePoint);
    }

    return middlePoints;
  }

  //find proportional point // change poisition from the middle points
  List<Point> findPropPoint(List<Point> middlePoints) {
    final propPoints = <Point>[];

    for (int i = 0; i < points.length - 2; i++) {
      //DISTANCE POINTS
      final firstDist = points[i].distance(points[i + 1]);
      final secondDist = points[i + 1].distance(points[i + 2]);

      //GET PROPORTIONS
      final proportion = firstDist / (firstDist + secondDist);

      //CHANGE THE MIDDLE POINT TO PROPORTIONAL POINTS
      final propPoint =
          middlePoints[i].makeMiddlePoint(middlePoints[i + 1], proportion);
      propPoints.add(propPoint);
    }

    return propPoints;
  }

  //find auxiliary Points // help points // вспомогательная точка
  List<Point> findAuxPoint(
      List<Point> middlePoints, List<Point> proportionalPoints) {
    final auxiliaryPoints = <Point>[];

    auxiliaryPoints.add(points[0]);
    for (int i = 0; i < proportionalPoints.length; i++) {

      final newPoints = points[i + 1].diff(proportionalPoints[i]);

      //CHANGE TO NEW POSITION POINTS
      final firstAuxPoint = middlePoints[i].changeOffset(newPoints);
      final secondAuxPoint = middlePoints[i + 1].changeOffset(newPoints);

      auxiliaryPoints.add(firstAuxPoint);
      auxiliaryPoints.add(secondAuxPoint);
    }
    auxiliaryPoints.add(points[points.length - 1]);

    return auxiliaryPoints;
  }

  //DRAW THE SPLINE
  void paint(Canvas canvas, Paint paint) {
    final middlePoints = findMidPoint();
    final proportionalPoints = findPropPoint(middlePoints);
    final auxiliaryPoints = findAuxPoint(middlePoints, proportionalPoints);

    final bezierCurves = <BezierCurve>[];

    for (int i = 0; i < points.length - 1; i++) {
      final newBezierCurve = BezierCurve([
        points[i],
        auxiliaryPoints[2 * i],
        auxiliaryPoints[2 * i + 1],
        points[i + 1],
      ]);

      bezierCurves.add(newBezierCurve);
    }

    for (final bezierCurve in bezierCurves) {
      final curvePoints = bezierCurve.makeBezierCurve();
      for (final point in curvePoints) {
        point.paint(canvas, color: paint.color);
      }
    }
  }
}
