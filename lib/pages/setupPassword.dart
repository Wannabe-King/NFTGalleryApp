import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_gallary_app/utils/buttonX.dart';

class SetUpPasswordPage extends StatefulWidget {
  final String? mnemonic;

  const SetUpPasswordPage({super.key, required this.mnemonic});

  @override
  State<SetUpPasswordPage> createState() => _SetUpPasswordPageState();
}

class _SetUpPasswordPageState extends State<SetUpPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Up Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  }),
              const SizedBox(height: 16),
              TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirm password is required';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  }),
              const SizedBox(height: 16),
              ButtonX(buttonLable: "Submit", click: _submit)
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (formKey.currentState!.validate()) {
      print("validate");
      if (passwordController.text != confirmPasswordController.text) {
        return;
      }

      await storage.write(key: 'password', value: passwordController.text);
      await storage.write(key: 'mnemonic', value: widget.mnemonic);

      GoRouter.of(context).go("/");
    }
  }
}
