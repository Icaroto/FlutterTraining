import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proto_dex/models/preferences.dart';
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
  @override
  void initState() {
    loadFiles();
    super.initState();
  }

  Future<String> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load server version');
    }
  }

  void loadFiles() async {
    await FileManager.loadDirectory();

    Data serverData =
        Data.fromJson(jsonDecode(await fetchData(kServerVersionLocation)));

    FileManager fManager = FileManager();
    bool checkVersioning = true;

    //********* Resolve Versions file *********\\
    File localDataFile = fManager.findFile('versions');
    if (localDataFile.readAsStringSync().isEmpty) {
      localDataFile.writeAsStringSync(jsonEncode(serverData));
      checkVersioning = false;
    }
    //***************************************\\

    //********* Resolve Pokedex file *********\\
    File pokedexLocalFile = fManager.findFile('pokedex');
    if (pokedexLocalFile.readAsStringSync().isEmpty) {
      String serverPokedex = await fetchData(kServerPokedexLocation);
      pokedexLocalFile.writeAsStringSync(serverPokedex);
    }
    //***************************************\\

    //********* Resolve Preferences file *********\\
    File preferencesLocalFile = fManager.findFile('preferences');
    if (preferencesLocalFile.readAsStringSync().isEmpty) {
      String serverPreferences = await fetchData(kServerPreferences);
      preferencesLocalFile.writeAsStringSync(serverPreferences);
    }

    kPreferences = Preferences.fromJson(
        jsonDecode(preferencesLocalFile.readAsStringSync()));
    //***************************************\\

    Data localData =
        Data.fromJson(jsonDecode(localDataFile.readAsStringSync()));

    if (serverData.app > localData.app) {
      displayUpdateAlert();
      checkVersioning = false;
    }

    if (checkVersioning) {
      if (serverData.dex > localData.dex) {
        String latestPokedex = await fetchData(kServerPokedexLocation);
        pokedexLocalFile.writeAsStringSync(latestPokedex);

        localData.dex = serverData.dex;
        localDataFile.writeAsStringSync(jsonEncode(localData));
      }
    }

    //For debugging:
    // var file = await rootBundle.loadString(kPokedexFileLocation);
    // kPokedex = await Pokemon.createPokedex(file);

    kPokedex = await Pokemon.createPokedex(pokedexLocalFile.readAsStringSync());
    //await Future.delayed(const Duration(seconds: 2));
    pushNextScreen();
  }

  //if major verison on server is higher, means a breaking change on files exists
  //eg. new properties on json or new reading/writing in files
  //if that's the case, all updates will be skipped until the app is updated to latest
  displayUpdateAlert() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Wait!'),
        content: const Text(
            "There's a new version available. You should probably get it!"),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {},
          ),
        ],
      ),
    );
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
