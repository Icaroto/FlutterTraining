import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'start_screen.dart';
import 'package:proto_dex/file_manager.dart';
import 'package:proto_dex/styles.dart';
import 'package:proto_dex/models/pokemon.dart';
import 'package:proto_dex/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    loadFiles();
    super.initState();
  }

  void loadFiles() async {
    var file = await rootBundle.loadString(kPokedexFileLocation);
    kPokedex = await Pokemon.createPokedex(file);

    await FileManager.loadDirectory();
    //TODO:Remove the seconds from here
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
