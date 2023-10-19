import 'package:flutter/material.dart';
import 'package:proto_dex/components/main_button.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/collection/collection_list_screen.dart';
import 'package:proto_dex/fortrade/fortrade_list_screen.dart';
import 'package:proto_dex/pokedex/pokedex_list_screen.dart';
import 'package:proto_dex/screens/preferences_screen.dart';
import 'package:proto_dex/screens/select_tracker_screen.dart';
import 'package:proto_dex/styles.dart';

import '../lookingfor/lookingfor_list_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1D1E33),
        // foregroundColor: Colors.white,
        onPressed: () {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text('Under Construction'),
          //     ),
          //   );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const PreferencesScreen();
              },
            ),
          );
        },
        child: const Icon(Icons.settings),
      ),
      body: Stack(
        children: <Widget>[
          kBasicBackground,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainScreenButton(
                    buttonName: 'Pokedex',
                    imagePath: 'main/bulbasaur.png',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PokedexListScreen(pokemons: kPokedex);
                          },
                        ),
                      );
                    },
                  ),
                  MainScreenButton(
                    buttonName: 'Trackers',
                    imagePath: 'main/squirtle.png',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SelectTrackerScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainScreenButton(
                    buttonName: 'Collection',
                    imagePath: 'main/mew.png',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CollectionScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainScreenButton(
                    buttonName: 'Looking For',
                    imagePath: 'main/charmander.png',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const LookingForScreen();
                          },
                        ),
                      );
                    },
                  ),
                  MainScreenButton(
                    buttonName: 'For Trade',
                    imagePath: 'main/pikachu.png',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const ForTradeScreen();
                          },
                        ),
                      );
                    },
                    // onPressed: () {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text('Under Construction')));
                    // },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
