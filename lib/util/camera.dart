import 'package:visual3d/model/transform3d.dart';

class Camera {
  static final Camera _main = Camera(
    transform: Transform3D(),
    fieldOfView: 60,
    minDistance: 0.3,
    maxDistance: 1000,
  );

  static Camera get main {
    return _main;
  }

  final Transform3D transform;
  final int fieldOfView;
  final double minDistance;
  final double maxDistance;

  Camera({
    required this.transform,
    required this.fieldOfView,
    required this.minDistance,
    required this.maxDistance,
  });
}
