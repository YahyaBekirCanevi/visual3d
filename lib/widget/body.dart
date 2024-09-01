import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual3d/model/scene_object3d.dart';
import 'package:visual3d/model/scene_object_drawer.dart';
import 'package:visual3d/util/SceneObjectChangeModifier.dart';
import 'package:visual3d/util/load_file_obj.dart';
import 'package:visual3d/widget/transform_widget.dart';
import 'package:visual3d/widget/visualizer3d.dart';

class AppBody extends StatefulWidget {
  const AppBody({super.key, required this.drawer});

  final SceneObjectDrawer drawer;

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  late Future<SceneObject3D> _sceneObjectFuture;

  @override
  void initState() {
    super.initState();
    _sceneObjectFuture = LoadFileObj.loadObjFile('assets/model/monkey.obj');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _sceneObjectFuture,
      builder: (context, result) {
        return switch (result.connectionState) {
          ConnectionState.waiting =>
            const CircularProgressIndicator(color: Colors.white),
          _ => _FutureData(result: result, drawer: widget.drawer),
        };
      },
    );
  }
}

class _FutureData extends StatelessWidget {
  const _FutureData({required this.result, required this.drawer});

  final AsyncSnapshot<SceneObject3D> result;
  final SceneObjectDrawer drawer;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SceneObjectChangeModifier(
        sceneObject: result.requireData,
      ),
      child: Stack(
        children: [
          SizedBox.expand(
            child: result.hasData
                ? Consumer<SceneObjectChangeModifier>(
                    builder: (context, obj, child) {
                    return CustomPaint(
                      painter: My3DVisualizer(
                        sceneObjects: [obj.sceneObject],
                        drawer: drawer,
                      ),
                      child: Container(),
                    );
                  })
                : Text(
                    result.error?.toString() ?? "Error",
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
          ),
          Visibility(
            visible: result.hasData,
            child: Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: TransformWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
