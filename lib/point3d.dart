import 'dart:math';

import 'package:flutter/material.dart';

class Point3D {
  double x;
  double y;
  double z;

  Point3D(this.x, this.y, this.z);

  Offset project(Size size) {
    // Simple orthographic projection
    double factor = 1 / (z / 500 + 1);
    return Offset(x * factor + size.width / 2, y * factor + size.height / 2);
  }
  
  double length() {
    return sqrt(x * x + y * y + z * z);
  }


  @override
  String toString() {
    return 'Point3D{x: $x, y: $y, z: $z}';
  }

  static Point3D normalize(Point3D p) {
    double length = p.length();
    return Point3D(p.x / length, p.y / length, p.z / length);
  }
  static Point3D zero() {
    return Point3D(0, 0, 0);
  }
  static Point3D one() {
    return Point3D(1, 1, 1);
  }
}
