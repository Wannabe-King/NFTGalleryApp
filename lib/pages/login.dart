import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_gallary_app/utils/buttonX.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  bool validationFailed = false;
  String? password;
  bool _loading = true;
  String? key;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    _checkForSavedLogin().then((credentialFound) {
      if (!credentialFound) {
        GoRouter.of(context).go("/setup");
      } else {
        setState(() {
          _loading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
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
        title: const Text(
          "Login",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value != password) {
                            setState(() {
                              validationFailed = true;
                            });
                            return;
                          }
                          GoRouter.of(context).go("/home");
                        },
                      ),
                      validationFailed
                          ? const Text(
                              "Invalid Password",
                              style: TextStyle(color: Colors.red),
                            )
                          : Container(),
                      const SizedBox(
                        height: 32,
                      ),
                      ButtonX(buttonLable: "Login", click: _onSubmit),
                      const SizedBox(
                        height: 20,
                      ),
                      ButtonX(
                          buttonLable: "Use Different Account",
                          click: () {
                            onDifferentAccountPressed(context);
                          })
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<bool> _checkForSavedLogin() async {
    key = await storage.read(key: 'mnemonic');
    password = await storage.read(key: 'password');
    if (key == null || password == null) {
      return false;
    }
    return true;
  }

  Future<dynamic> onDifferentAccountPressed(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: const Text(
                'Access to current account will be lost if seed phrase is lost.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).go("/setup");
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
}
