import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visual3d/model/point3d.dart';
import 'package:visual3d/model/scene_object3d.dart';
import 'package:visual3d/model/transform3d.dart';

class LoadFileObj {
  static Future<SceneObject3D> loadObjFile(String path) async {
    String data = await rootBundle.loadString(path);
    return parseObjFile(data);
  }

  static SceneObject3D parseObjFile(String data) {
    List<Point3D> vertices = [];
    List<Point3D> normals = [];
    List<List<int>> faces = [];
    List<Color> textures = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow
    ];

    List<String> lines = data.split('\n');
    for (String line in lines) {
      if (line.startsWith('v ')) {
        List<String> parts = line.split(' ');
        vertices.add(Point3D(
          double.parse(parts[1]),
          double.parse(parts[2]),
          double.parse(parts[3]),
        ));
      } else if (line.startsWith('vn ')) {
        List<String> parts = line.split(' ');
        normals.add(Point3D(
          double.parse(parts[1]),
          double.parse(parts[2]),
          double.parse(parts[3]),
        ));
      } else if (line.startsWith('f ')) {
        List<String> parts = line.split(' ');
        parts.removeAt(0);
        faces.add(parts.map((p) => int.parse(p.split('/')[0]) - 1).toList());
      }
    }

    Transform3D transform = Transform3D(
      position: Point3D(0, 0, -100),
      rotation: Points.zero(),
      scale: Point3D(100, 100, 100),
    );

    return SceneObject3D(
      points: vertices,
      normals: normals,
      faces: faces,
      textures: textures,
      transform: transform,
    );
  }
}