import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/detail.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id', null);

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
