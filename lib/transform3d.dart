import 'dart:math';

import 'package:visual3d/point3d.dart';

class Transform3D {
  Point3D position = Point3D.zero();
  Point3D rotation = Point3D.zero();
  Point3D scale = Point3D.one();

  Transform3D({
    Point3D? position,
    Point3D? rotation,
    Point3D? scale,
  }) {
    this.position = position ?? Point3D.zero();
    this.rotation = rotation ?? Point3D.zero();
    this.scale = scale ?? Point3D.one();
  }

  // Apply transformations to a point
  Point3D apply(Point3D point) {
    Point3D transformed = enlarge(point);
    transformed = rotate(transformed);
    transformed = translate(transformed);
    return transformed;
  }

  // Scale transformation
  Point3D enlarge(Point3D point) {
    return Point3D(
      point.x * scale.x,
      point.y * scale.y,
      point.z * scale.z,
    );
  }

  // Rotation transformation
  Point3D rotate(Point3D point) {
    // Rotate around X axis
    Point3D rotatedX = Point3D(
      point.x,
      point.y * cos(rotation.x) - point.z * sin(rotation.x),
      point.y * sin(rotation.x) + point.z * cos(rotation.x),
    );

    // Rotate around Y axis
    Point3D rotatedY = Point3D(
      rotatedX.x * cos(rotation.y) + rotatedX.z * sin(rotation.y),
      rotatedX.y,
      -rotatedX.x * sin(rotation.y) + rotatedX.z * cos(rotation.y),
    );

    // Rotate around Z axis
    Point3D rotatedZ = Point3D(
      rotatedY.x * cos(rotation.z) - rotatedY.y * sin(rotation.z),
      rotatedY.x * sin(rotation.z) + rotatedY.y * cos(rotation.z),
      rotatedY.z,
    );

    return rotatedZ;
  }

  // Translation transformation
  Point3D translate(Point3D point) {
    return Point3D(
      point.x + position.x,
      point.y + position.y,
      point.z + position.z,
    );
  }
  void selfScale(Point3D point) {
    scale = enlarge(point);
  }
  void selfRotate(Point3D point) {
    rotation = rotate(point);
  }
  void selfTranslate(Point3D point) {
    position = translate(point);
  }
}
