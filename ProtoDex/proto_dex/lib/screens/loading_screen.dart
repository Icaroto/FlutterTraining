import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proto_dex/models/version.dart';
import 'start_screen.dart';
import 'package:proto_dex/file_manager.dart';
import 'package:proto_dex/styles.dart';
import 'package:proto_dex/models/pokemon.dart';
import 'package:proto_dex/constants.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Future<Version> serverVersion;

  @override
  void initState() {
    serverVersion = fetchVersions();
    loadFiles();
    super.initState();
  }

  Future<Version> fetchVersions() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/Icaroto/FlutterTraining/main/ProtoDex/ServerVersions/versions.json'));

    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Version.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  void loadFiles() async {
    var file = await rootBundle.loadString(kPokedexFileLocation);
    kPokedex = await Pokemon.createPokedex(file);

    await FileManager.loadDirectory();
    //await Future.delayed(const Duration(seconds: 2));
    pushNextScreen();
  }

  void pushNextScreen() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const StartScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.network(
                '${kImageLocalPrefix}background/colored_ball.png'),
          ),
          const Text(
            'Loading...',
            style: loadingTextStyle,
          )
        ],
      ),
    );
  }
}
