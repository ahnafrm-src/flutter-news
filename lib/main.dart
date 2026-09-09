import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/detail': (context) =>
            Detail(sw: ModalRoute.of(context)!.settings.arguments as dynamic),
      },
    );
  }
}
