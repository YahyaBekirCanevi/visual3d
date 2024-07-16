import 'dart:math';

import 'package:flutter/material.dart';
import 'package:visual3d/point3d.dart';
import 'package:visual3d/transform3d.dart';

class SceneObject3D {
  List<Point3D> points;
  List<Color> textures;
  Point3D lightSource;
  Transform3D transform;

  SceneObject3D({
    required this.points,
    required this.textures,
    required this.lightSource,
    required this.transform,
  });

  void draw(Canvas canvas, Size size) {
    Paint paint = Paint()..strokeWidth = 2.0;
    List<Offset> projectedPoints = points.map((p) => transform.apply(p).project(size)).toList();

    // Draw faces with basic lighting
    drawFace(canvas, paint, [0, 1, 2, 3], points, projectedPoints, lightSource, textures[0]);
    drawFace(canvas, paint, [4, 5, 6, 7], points, projectedPoints, lightSource, textures[1]);
    drawFace(canvas, paint, [0, 1, 5, 4], points, projectedPoints, lightSource, textures[2]);
    drawFace(canvas, paint, [2, 3, 7, 6], points, projectedPoints, lightSource, textures[3]);
    drawFace(canvas, paint, [0, 3, 7, 4], points, projectedPoints, lightSource, textures[0]);
    drawFace(canvas, paint, [1, 2, 6, 5], points, projectedPoints, lightSource, textures[1]);
  }

  void drawFace(Canvas canvas, Paint paint, List<int> indices, List<Point3D> points,
      List<Offset> projectedPoints, Point3D lightSource, Color baseColor) {
    Point3D normal = calculateNormal(points[indices[0]], points[indices[1]], points[indices[2]]);
    double intensity = calculateLightIntensity(normal, points[indices[0]], lightSource);
    paint.color = baseColor.withOpacity(intensity);

    Path path = Path();
    path.moveTo(projectedPoints[indices[0]].dx, projectedPoints[indices[0]].dy);
    for (int i = 1; i < indices.length; i++) {
      path.lineTo(projectedPoints[indices[i]].dx, projectedPoints[indices[i]].dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  Point3D calculateNormal(Point3D p1, Point3D p2, Point3D p3) {
    Point3D u = Point3D(p2.x - p1.x, p2.y - p1.y, p2.z - p1.z);
    Point3D v = Point3D(p3.x - p1.x, p3.y - p1.y, p3.z - p1.z);
    return Point3D(u.y * v.z - u.z * v.y, u.z * v.x - u.x * v.z, u.x * v.y - u.y * v.x);
  }

  double calculateLightIntensity(Point3D normal, Point3D point, Point3D lightSource) {
    Point3D lightVector = Point3D(lightSource.x - point.x, lightSource.y - point.y, lightSource.z - point.z);
    normal = Point3D.normalize(normal);
    lightVector = Point3D.normalize(lightVector);
    double dotProduct = normal.x * lightVector.x + normal.y * lightVector.y + normal.z * lightVector.z;
    return max(0, min(1, dotProduct));
  }


}
