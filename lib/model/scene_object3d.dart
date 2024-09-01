import 'package:flutter/material.dart';
import 'package:visual3d/model/point3d.dart';
import 'package:visual3d/model/scene_object_drawer.dart';
import 'package:visual3d/model/transform3d.dart';
import 'package:visual3d/util/camera.dart';

class SceneObject3D {
  final List<Point3D> points;
  final List<Point3D> normals;
  final List<Color> textures;
  final List<List<int>> faces;
  final Transform3D transform;
  late SceneObjectDrawer _drawer;

  SceneObject3D({
    required this.points,
    required this.normals,
    required this.textures,
    required this.faces,
    required this.transform,
  });

  set drawer(SceneObjectDrawer value) {
    _drawer = value;
  }

  void draw(Canvas canvas, Size size) {
    Paint paint = Paint()..strokeWidth = 2.0;
    List<Offset> projectedPoints = points.map((p) => transform.apply(p).project(size)).toList();
    faces.sort((a, b) {
      double distanceA = a.map((i) => points[i].distanceTo(Camera.main.transform.position))
          .reduce((x, y) => x + y) / a.length;
      double distanceB = b.map((i) => points[i].distanceTo(Camera.main.transform.position))
          .reduce((x, y) => x + y) / b.length;
      return distanceA.compareTo(distanceB); // Sort in descending order
    });
    for (var i = 0; i < faces.length; i++) {
      _drawer.drawFace(canvas, paint, i, transform, faces[i], points, normals, projectedPoints, textures[i % textures.length]);
    }
  }
}
