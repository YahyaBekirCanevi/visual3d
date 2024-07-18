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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          title: const Text(
            '3D Visualizer with Lighting and Texturing',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: AppBody(),
      ),
    );
  }
}
