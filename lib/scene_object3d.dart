import 'dart:math';

import 'package:flutter/material.dart';
import 'package:visual3d/color_extension.dart';
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

  void draw(Canvas canvas, Size size, Point3D viewDirection) {
    Paint paint = Paint()..strokeWidth = 2.0;
    List<Offset> projectedPoints = points.map((p) => transform.apply(p).project(size)).toList();

    // Draw faces with basic lighting
    /*drawFace(canvas, paint, [0, 1, 2, 3], points, projectedPoints, lightSource, textures[0], viewDirection);
    drawFace(canvas, paint, [4, 5, 6, 7], points, projectedPoints, lightSource, textures[1], viewDirection);
    drawFace(canvas, paint, [0, 1, 5, 4], points, projectedPoints, lightSource, textures[2], viewDirection);
    drawFace(canvas, paint, [2, 3, 7, 6], points, projectedPoints, lightSource, textures[3], viewDirection);
    drawFace(canvas, paint, [0, 3, 7, 4], points, projectedPoints, lightSource, textures[0], viewDirection);
    drawFace(canvas, paint, [1, 2, 6, 5], points, projectedPoints, lightSource, textures[1], viewDirection);*/
    // Front face (indices in counter-clockwise order)
    drawFace(canvas, paint, [0, 1, 2], points, projectedPoints, lightSource, textures[0], viewDirection);
    drawFace(canvas, paint, [0, 2, 3], points, projectedPoints, lightSource, textures[0], viewDirection);

    // Back face (indices in counter-clockwise order)
    drawFace(canvas, paint, [4, 5, 6], points, projectedPoints, lightSource, textures[1], viewDirection);
    drawFace(canvas, paint, [4, 6, 7], points, projectedPoints, lightSource, textures[1], viewDirection);

    // Side faces (indices in counter-clockwise order)
    drawFace(canvas, paint, [1, 5, 6], points, projectedPoints, lightSource, textures[2], viewDirection);
    drawFace(canvas, paint, [1, 6, 2], points, projectedPoints, lightSource, textures[2], viewDirection);

    drawFace(canvas, paint, [0, 4, 7], points, projectedPoints, lightSource, textures[3], viewDirection);
    drawFace(canvas, paint, [0, 7, 3], points, projectedPoints, lightSource, textures[3], viewDirection);

    drawFace(canvas, paint, [2, 6, 7], points, projectedPoints, lightSource, textures[0], viewDirection);
    drawFace(canvas, paint, [2, 7, 3], points, projectedPoints, lightSource, textures[0], viewDirection);

    drawFace(canvas, paint, [0, 1, 5], points, projectedPoints, lightSource, textures[1], viewDirection);
    drawFace(canvas, paint, [0, 5, 4], points, projectedPoints, lightSource, textures[1], viewDirection);

  }

  void drawFace(Canvas canvas, Paint paint, List<int> indices, List<Point3D> points,
      List<Offset> projectedPoints, Point3D lightSource, Color baseColor, Point3D viewDirection) {
    Point3D normal = calculateNormal(
      points[indices[0]],
      points[indices[1]],
      points[indices[2]],
    );

    double dotProduct = normal.x * viewDirection.x + normal.y * viewDirection.y + normal.z * viewDirection.z;
    if (dotProduct < 0) return; // Skip drawing if face is not front-facing

    double intensity = calculateLightIntensity(normal, transform.apply(points[indices[0]]), lightSource);
    intensity = min(1, max(0, intensity));

    Color faceColor = baseColor.withSaturation(1 - intensity).withOpacity(1);

    paint.color = faceColor;
    paint.style = PaintingStyle.stroke;

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
