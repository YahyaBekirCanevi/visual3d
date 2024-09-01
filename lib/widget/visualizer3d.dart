import 'package:flutter/material.dart';
import 'package:visual3d/model/scene_object3d.dart';
import 'package:visual3d/model/scene_object_drawer.dart';

class My3DVisualizer extends CustomPainter {
  final List<SceneObject3D> sceneObjects;
  final SceneObjectDrawer drawer;

  const My3DVisualizer({
    required this.sceneObjects,
    required this.drawer,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (SceneObject3D e in sceneObjects) {
      e.drawer = drawer;
      e.draw(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
