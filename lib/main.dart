import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_gallary_app/pages/generatePhrase.dart';
import 'package:nft_gallary_app/pages/home.dart';
import 'package:nft_gallary_app/pages/inputPhrase.dart';
import 'package:nft_gallary_app/pages/login.dart';
import 'package:nft_gallary_app/pages/nft3dview.dart';
import 'package:nft_gallary_app/pages/setupAccount.dart';
import 'package:nft_gallary_app/pages/setupPassword.dart';
import 'package:nft_gallary_app/services/nft_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initialRPC();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

void initialRPC() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool value = await getRPCtype();
  await prefs.setBool('devnet', value);
}

final GoRouter _router = GoRouter(routes: <GoRoute>[
  GoRoute(
    path: '/',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/setup',
    builder: (context, state) => const SetUpAccountPage(),
  ),
  GoRoute(
    path: '/inputPhrase',
    builder: (context, state) => const InputPhrasePage(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/setupPassword/:privateKey',
    builder: (context, state) =>
        SetUpPasswordPage(mnemonic: state.pathParameters["privateKey"]),
  ),
  GoRoute(
    path: '/generatePhrase',
    builder: (context, state) => const GeneratePhrasePage(),
  ),
  // GoRoute(
  //   path: '/3dview',
  //   builder: (context, state) => Nft3dview(
  //       modelPath:
  //           "/storage/emulated/0/Android/data/com.example.nft_gallary_app/files/files/QmVfciq2QFcyb1PhqtbunY3tmRDPSw58Peq14vA2x2BMSo"),
  // )
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey[500],
        )),
        primaryColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.grey[850],
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
