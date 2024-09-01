import 'package:flutter/material.dart';
import 'package:visual3d/model/transform3d.dart';
import 'package:visual3d/util/color_extension.dart';
import 'package:visual3d/model/point3d.dart';

class SceneObjectDrawer  {
  List<Point3D> lightSources = List.of([]);

  void setLightSources(List<Point3D> lightSources) {
    this.lightSources = lightSources;
  }

  void drawFace(Canvas canvas, Paint paint, int faceIndex, Transform3D transform,
      List<int> indices, List<Point3D> points, List<Point3D> normals,
      List<Offset> projectedPoints, Color baseColor) {
    Point3D normal = calculateNormal(normals, faceIndex);

    //double dotProduct = Points.dot(Camera.main.transform.forward(), transform.rotate(normal));

    //if (dotProduct >= 0) return;

    double intensity = lightSources.isEmpty ? 0 : calculateLightIntensity(normal, points[indices[0]]);
    paint.color = baseColor.withSaturation(intensity);

    Path path = Path();
    path.moveTo(projectedPoints[indices[0]].dx, projectedPoints[indices[0]].dy);
    for (int i = 1; i < indices.length; i++) {
      path.lineTo(projectedPoints[indices[i]].dx, projectedPoints[indices[i]].dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  Point3D calculateNormal(List<Point3D> normals, int faceIndex) {
    return normals[faceIndex % normals.length];
  }

  double calculateLightIntensity(Point3D normal, Point3D point) {
    Point3D lightSource = lightSources.elementAt(0);
    Point3D lightDirection = Points.normalize(Point3D(
      lightSource.x - point.x,
      lightSource.y - point.y,
      lightSource.z - point.z,
    ));
    double dotProduct = normal.x * lightDirection.x + normal.y * lightDirection.y + normal.z * lightDirection.z;
    return (dotProduct + 1) / 2; // Normalize to range 0-1
  }
}
