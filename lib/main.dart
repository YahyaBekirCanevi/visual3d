import 'package:flutter/material.dart';
import 'package:visual3d/body.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('3D Visualizer with Lighting and Texturing'),
        ),
        body: AppBody(),
      ),
    );
  }
}
