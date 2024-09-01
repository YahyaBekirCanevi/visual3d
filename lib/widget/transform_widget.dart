import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual3d/model/point3d.dart';
import 'package:visual3d/util/SceneObjectChangeModifier.dart';

class TransformWidget extends StatefulWidget {
  const TransformWidget({super.key});

  @override
  State<TransformWidget> createState() => _TransformWidgetState();
}

class _TransformWidgetState extends State<TransformWidget> {
  bool isLeftMouseDown = false;
  bool isRightMouseDown = false;
  Offset lastMousePosition = Offset.zero;
  @override
  Widget build(BuildContext context) {
    return Consumer<SceneObjectChangeModifier>(builder: (context, obj, child) {
      return GestureDetector(
        onPanUpdate: (details) {
          Offset delta = details.localPosition - lastMousePosition;
          double perimeter = 0.01;
          obj.rotate(Point3D((delta.dy / delta.distance) * perimeter, (-delta.dx / delta.distance) * perimeter, 0));
          setState(() {
            lastMousePosition = details.localPosition;
          });
        },
        onPanEnd: (details) {
          setState(() {
            lastMousePosition = Offset.zero;
          });
        },
        /*onScaleUpdate: (details) {
            print("onScaleUpdate");
            setState(() {
              widget.transform.scale.x *= details.scale;
              widget.transform.scale.y *= details.scale;
              widget.transform.scale.z *= details.scale;
            });
          },*/
        child: Container(
          color: Colors.transparent, // Background for mouse interaction
          width: MediaQuery.sizeOf(context).width * .4,
          child: const Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Use mouse to transform the object:\n'
              ' - Left Click: Orbit\n'
              ' - Right Click: Move\n'
              ' - Scroll: Scale',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    });
  }
}
