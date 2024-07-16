import 'dart:math';

import 'package:flutter/material.dart';
import 'package:visual3d/point3d.dart';
import 'package:visual3d/scene_object3d.dart';
import 'package:visual3d/transform3d.dart';
import 'package:visual3d/visualizer3d.dart';

class AppBody extends StatefulWidget {
  AppBody({super.key});

  final List<Point3D> points = [
    Point3D(-100, -100, -100),
    Point3D(100, -100, -100),
    Point3D(100, 100, -100),
    Point3D(-100, 100, -100),
    Point3D(-100, -100, 100),
    Point3D(100, -100, 100),
    Point3D(100, 100, 100),
    Point3D(-100, 100, 100),
  ];

  final List<Color> textures = [
    Colors.amber,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.black,
    Colors.blueGrey,
  ];
  final Point3D lightSource = Point3D(150, 150, 150);

  final Transform3D transform = Transform3D(
    position: Point3D.zero(),
    rotation: Point3D.zero(),
    scale: Point3D.one(),
  );

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    SceneObject3D sceneObject = SceneObject3D(
      points: widget.points,
      textures: widget.textures,
      lightSource: widget.lightSource,
      transform: widget.transform,
    );
    return Stack(
      children: [
        SizedBox.expand(
          child: CustomPaint(
            painter: My3DVisualizer(
              sceneObjects: [sceneObject],
              viewDirection: Point3D(0, 0, 1),
            ),
            child: Container(),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          width: size.width * .3,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text("Position:"),
                    Text(widget.transform.position.x.toStringAsFixed(3)),
                    Slider(
                      divisions: 201,
                      min: -1000,
                      max: 1000,
                      value: widget.transform.position.x,
                      onChanged: (val) => setState(() {
                        widget.transform.position.x = val;
                      }),
                    ),
                    Text(widget.transform.position.y.toStringAsFixed(3)),
                    Slider(
                      divisions: 201,
                      min: -1000,
                      max: 1000,
                      value: -widget.transform.position.y,
                      onChanged: (val) => setState(() {
                        widget.transform.position.y = -val;
                      }),
                    ),
                    Text(widget.transform.position.z.toStringAsFixed(3)),
                    Slider(
                      divisions: 201,
                      min: -1000,
                      max: 1000,
                      value: -widget.transform.position.z,
                      onChanged: (val) => setState(() {
                        widget.transform.position.z = -val;
                      }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text("Rotation:"),
                    Text(widget.transform.rotation.x.toStringAsFixed(3)),
                    Slider(
                      divisions: 201,
                      min: -1000,
                      max: 1000,
                      value: widget.transform.rotation.x * 180 / pi,
                      onChanged: (val) => setState(() {
                        Point3D point = widget.transform.rotation;
                        point.x = val * pi / 180;
                        widget.transform.rotation = point;
                      }),
                    ),
                    Text(widget.transform.rotation.y.toStringAsFixed(3)),
                    Slider(
                      divisions: 201,
                      min: -1000,
                      max: 1000,
                      value: widget.transform.rotation.y * 180 / pi,
                      onChanged: (val) => setState(() {
                        Point3D point = widget.transform.rotation;
                        point.y = val * pi / 180;
                        widget.transform.rotation = point;
                      }),
                    ),
                    Text(widget.transform.rotation.z.toStringAsFixed(3)),
                    Slider(
                      divisions: 201,
                      min: -1000,
                      max: 1000,
                      value: widget.transform.rotation.z * 180 / pi,
                      onChanged: (val) => setState(() {
                        Point3D point = widget.transform.rotation;
                        point.z = val * pi / 180;
                        widget.transform.rotation = point;
                      }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text("Scale:"),
                    Text(widget.transform.scale.x.toStringAsFixed(3)),
                    Slider(
                      divisions: 100,
                      min: 0.01,
                      max: 10,
                      value: widget.transform.scale.x,
                      onChanged: (val) => setState(() {
                        widget.transform.scale.x = val;
                      }),
                    ),
                    Text(widget.transform.scale.y.toStringAsFixed(3)),
                    Slider(
                      divisions: 100,
                      min: 0.01,
                      max: 10,
                      value: widget.transform.scale.y,
                      onChanged: (val) => setState(() {
                        widget.transform.scale.y = val;
                      }),
                    ),
                    Text(widget.transform.scale.z.toStringAsFixed(3)),
                    Slider(
                      divisions: 100,
                      min: 0.01,
                      max: 10,
                      value: widget.transform.scale.z,
                      onChanged: (val) => setState(() {
                        widget.transform.scale.z = val;
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
