import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'start_screen.dart';
import '../components/pokemon.dart';
import '../components/constants.dart';

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
    Map<String, String> files = {
      kPokedexKey: await rootBundle.loadString(kPokedexFileLocation),
      kCollectionKey: await rootBundle.loadString(kCollectionFileLocation),
      kLookingForKey: await rootBundle.loadString(kLookingForFileLocation),
      kForTradeKey: await rootBundle.loadString(kForTradeFileLocation)
    };

    List<Pokemon> pokedex =
        await Pokemon.createPokemonList(files[kPokedexKey]!);
    await Future.delayed(const Duration(seconds: 2));

    pushNextScreen(pokedex, files);
  }

  void pushNextScreen(pokedex, files) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return StartScreen(pokedex: pokedex, files: files);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: kLoading);
  }
}
