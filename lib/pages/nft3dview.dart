import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Nft3dview extends StatelessWidget {
  final String? modelPath;
  const Nft3dview({super.key, required this.modelPath});

  @override
  Widget build(BuildContext context) {
    print(modelPath);
    Flutter3DController controller = Flutter3DController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("3d View"),
      ),
      body: Flutter3DViewer(
        // src: "assets/model.glb",
        src: "$modelPath",
        // src:
        //     "https://assets.meshy.ai/fe61d275-c975-4457-a36f-8e90ef8c6321/tasks/0191a442-81fe-712a-b564-f6db147ba932/output/model.glb?Expires=1725297064&Signature=qLJIl9jPURU~wVkvsxU3KOwYFaQu7zmOYrsHa3Se1SAdPOInTGsGjg7atizP~jS1KLGrXI7g3WNbDrUtwnaEXOmepphCJdis~eHb-LspA96HKywvM7Iuc8tlxjmQ9R0ODcmmqbYIIoP59tTr4XRW8x-CsBlMnv4b3OF6hgkiRCuZCi~JSU4h410X927AwXieDEivBBngXCEnoHDy-yoLIvmNKrq--76N8Y3cv0cOA7ww0O1EmDasA9bEjfrc1EhLZX46~Umyy5inoTNJwIO9NFbr~UNHSONQpgifbUpK873E1QUfJKhALsQ54IZmSmCXKIxMzpPSWNJ3hY4Co3Qkqw__&Key-Pair-Id=KL5I0C8H7HX83",
        controller: controller,
      ),
      // body: BabylonJSViewer(
      //   src:
      //       "https://assets.meshy.ai/fe61d275-c975-4457-a36f-8e90ef8c6321/tasks/0191a442-81fe-712a-b564-f6db147ba932/output/model.glb?Expires=1725297064&Signature=qLJIl9jPURU~wVkvsxU3KOwYFaQu7zmOYrsHa3Se1SAdPOInTGsGjg7atizP~jS1KLGrXI7g3WNbDrUtwnaEXOmepphCJdis~eHb-LspA96HKywvM7Iuc8tlxjmQ9R0ODcmmqbYIIoP59tTr4XRW8x-CsBlMnv4b3OF6hgkiRCuZCi~JSU4h410X927AwXieDEivBBngXCEnoHDy-yoLIvmNKrq--76N8Y3cv0cOA7ww0O1EmDasA9bEjfrc1EhLZX46~Umyy5inoTNJwIO9NFbr~UNHSONQpgifbUpK873E1QUfJKhALsQ54IZmSmCXKIxMzpPSWNJ3hY4Co3Qkqw__&Key-Pair-Id=KL5I0C8H7HX83",
      // ),
    );
  }
}



// This code is not usable because we are not able to retrive retrive the glb model from the android local storage folder or from the model url link as the meshy api has is blocking us from access for 3d viewer.