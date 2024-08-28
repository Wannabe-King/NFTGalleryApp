import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_gallary_app/utils/buttonX.dart';

class SetUpAccountPage extends StatelessWidget {
  const SetUpAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set up Account"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonX(
                buttonLable: "I have a recovery phrase",
                click: () => context.go('/inputPhrase')),
            const SizedBox(
              height: 20,
            ),
            ButtonX(
                buttonLable: "Generate new wallet",
                click: () => context.go("/generatePhrase"))
          ],
        ),
      ),
    );
  }
}
