import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_gallary_app/services/nft_api.dart';
import 'package:nft_gallary_app/utils/buttonX.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetUpAccountPage extends StatefulWidget {
  const SetUpAccountPage({super.key});

  @override
  State<SetUpAccountPage> createState() => _SetUpAccountPageState();
}

class _SetUpAccountPageState extends State<SetUpAccountPage> {
  final storage = const FlutterSecureStorage();
  bool _devnetEnabled = false;

  @override
  void initState() {
    setAccountIn();
    super.initState();
  }

  void setAccountIn() async {
    bool temp = await getRPCtype();
    setState(() {
      _devnetEnabled = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "This App Only Works for Solana Wallets",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      appBar: AppBar(
        title: const Text("Set up Account"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _devnetEnabled ? "Devnet" : "Mainnet",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Switch(
                      value: _devnetEnabled,
                      onChanged: (value) {
                        setState(() {
                          _devnetEnabled = value;
                          setRPCtype(value);
                        });
                      }),
                ],
              ),
            ),
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
