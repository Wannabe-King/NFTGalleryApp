import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Nft3dview extends StatelessWidget {
  final String? modelPath;
  const Nft3dview({super.key, required this.modelPath});

  @override
  Widget build(BuildContext context) {
    Flutter3DController controller = Flutter3DController();
    return Scaffold(
      body: Flutter3DViewer(
        src: "$modelPath.glb",
        controller: controller,
      ),
    );
  }
}
