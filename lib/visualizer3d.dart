import 'package:flutter/material.dart';
import 'package:visual3d/scene_object3d.dart';

class My3DVisualizer extends CustomPainter {
  final List<SceneObject3D> sceneObjects;

  My3DVisualizer({required this.sceneObjects});

  @override
  void paint(Canvas canvas, Size size) {
    for (SceneObject3D e in sceneObjects) {
      e.draw(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
