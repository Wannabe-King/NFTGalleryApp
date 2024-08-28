import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
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
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
