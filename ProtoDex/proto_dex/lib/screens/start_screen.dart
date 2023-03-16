import 'package:flutter/material.dart';
import 'package:proto_dex/components/main_button.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/screens/collection_screen.dart';
import 'package:proto_dex/screens/select_tracker_screen.dart';
import 'package:proto_dex/styles.dart';
import 'list_screen.dart';

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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Under Construction'),
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
                    imagePath: 'images/background/colored_ball.png',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ListScreen(pokemons: kPokedex);
                          },
                        ),
                      );
                    },
                  ),
                  MainScreenButton(
                    buttonName: 'Trackers',
                    imagePath: 'images/background/colored_ball.png',
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
                    imagePath: 'images/background/colored_ball.png',
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
                    buttonName: 'LF',
                    imagePath: 'images/background/colored_ball.png',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Under Construction')));
                    },
                  ),
                  MainScreenButton(
                    buttonName: 'FT',
                    imagePath: 'images/background/colored_ball.png',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Under Construction')));
                    },
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
