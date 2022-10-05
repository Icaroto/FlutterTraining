import 'package:flutter/material.dart';
import 'package:proto_dex/screens/list.dart';
import 'package:proto_dex/screens/start_screen.dart';
import '../screens/loading_screen.dart';
import '../screens/base_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          backgroundColor: Colors.green,
          primaryColor: Colors.green,
          primaryTextTheme: TextTheme(
            bodyText1: TextStyle(
              fontFamily: 'SigmarOne',
              fontSize: 15,
              color: Colors.blue,
            ),
          ),
          scaffoldBackgroundColor: Colors.blueGrey[900]),

      home: ListScreen(),
      // home: Scaffold(body: LoadingScreen()),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => Scaffold(body: LoadingScreen()),
      //   '/start_screen': (context) => Scaffold(body: StartScreen(file: null))N,
      //   '/pokedex_list': (context) => ListPage(),
      // },
    );
  }
}

/*Flutter Notes:
Use color from main theme
  color: Theme.of(context).backgroundColor, <-- Inside Container

*/