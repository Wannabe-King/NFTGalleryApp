import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_gallary_app/utils/buttonX.dart';
import 'package:bip39/bip39.dart' as bip39;

class InputPhrasePage extends StatefulWidget {
  const InputPhrasePage({super.key});

  @override
  State<InputPhrasePage> createState() => _InputPhrasePageState();
}

class _InputPhrasePageState extends State<InputPhrasePage> {
  final _formKey = GlobalKey<FormState>();
  final _words = List<String>.filled(12, '');
  bool validationFailed = false;

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
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  const Text('Please enter your recovery phrase',
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 32),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Container(
                          width: 300,
                          height: 400,
                          padding: const EdgeInsets.all(8),
                          child: GridView.count(
                            padding: const EdgeInsets.all(3),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 3,
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            children: List.generate(12, (index) {
                              return SizedBox(
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: '${index + 1}',
                                  ),
                                  onSaved: (value) {
                                    _words[index] = value!;
                                  },
                                ),
                              );
                            }),
                          )),
                    ),
                  ),
                  Text(validationFailed ? 'Invalid keyphrase' : '',
                      style: const TextStyle(color: Colors.red)),
                  // const Spacer(),
                  ButtonX(
                      buttonLable: "Continue", click: () => _onSubmit(context)),
                  const SizedBox(
                    height: 32,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit(context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String wordsString = _words.join(' ');
      final t = bip39.validateMnemonic(wordsString);
      if (t) {
        GoRouter.of(context).go("/setupPassword/$wordsString");
      } else {
        setState(() {
          validationFailed = true;
        });
      }
    }
  }
}
