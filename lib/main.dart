import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_gallary_app/pages/generatePhrase.dart';
import 'package:nft_gallary_app/pages/home.dart';
import 'package:nft_gallary_app/pages/inputPhrase.dart';
import 'package:nft_gallary_app/pages/login.dart';
import 'package:nft_gallary_app/pages/setupAccount.dart';
import 'package:nft_gallary_app/pages/setupPassword.dart';

void main() {
  runApp(const MyApp());
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
    builder: (context, state) => const SetUpPasswordPage(privateKey:state.pathParameters["privateKey"]),
  ),
  GoRoute(
    path: '/generatePhrase',
    builder: (context, state) => const GeneratePhrasePage(),
  )
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
