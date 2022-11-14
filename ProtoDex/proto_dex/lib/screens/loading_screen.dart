import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../file_manager.dart';
import 'start_screen.dart';
import '../models/pokemon.dart';
import '../constants.dart';

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
    // Map<String, String> files = {
    //   kPokedexKey: await rootBundle.loadString(kPokedexFileLocation),
    // kCollectionKey: await rootBundle.loadString(kCollectionFileLocation),
    // kLookingForKey: await rootBundle.loadString(kLookingForFileLocation),
    // kForTradeKey: await rootBundle.loadString(kForTradeFileLocation)
    // };

    String file = await rootBundle.loadString(kPokedexFileLocation);
    List<Pokemon> pokedex = await Pokemon.createPokedex(file);

    await FileManager.loadDirectory();
    //TODO:Remove the seconds from here
    //await Future.delayed(const Duration(seconds: 2));

    pushNextScreen(pokedex);
  }

  void pushNextScreen(pokedex) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return StartScreen(pokedex: pokedex);
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
            child: Image.asset('images/background/colored_ball.png'),
          ),
          const Text('Loading...',
              style: TextStyle(fontSize: 30, color: Colors.amber))
        ],
      ),
    );
  }
}
