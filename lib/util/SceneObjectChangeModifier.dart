import 'package:flutter/material.dart';
import 'package:visual3d/model/point3d.dart';
import 'package:visual3d/model/scene_object3d.dart';
import 'package:visual3d/model/transform3d.dart';

class SceneObjectChangeModifier extends ChangeNotifier {
  late SceneObject3D _sceneObject;
  Point3D position = Points.zero();
  Point3D rotation = Points.zero();
  Point3D scaling = Points.one();


  SceneObjectChangeModifier({required SceneObject3D sceneObject}) {
    _sceneObject = sceneObject;
  }

  SceneObject3D get sceneObject => _sceneObject;

  Transform3D get transform => _sceneObject.transform;

  move(Point3D point) {
    position.add(point);
    transform.selfTranslate(position);
    notifyListeners();
  }
  rotate(Point3D point) {
    rotation.add(point);
    transform.selfRotate(rotation);
    notifyListeners();
  }
  scale(Point3D point) {
    scaling.scale(point);
    transform.selfScale(scaling);
    notifyListeners();
  }

}