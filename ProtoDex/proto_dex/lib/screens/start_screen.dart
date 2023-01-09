import 'package:flutter/material.dart';
import 'package:proto_dex/components/main_button.dart';
import 'package:proto_dex/components/options.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/models/collection.dart';
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
      body: Stack(
        children: <Widget>[
          kBasicBackground,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  // MainScreenButton(
                  //   buttonName: 'Tracker',
                  //   imagePath: 'images/background/colored_ball.png',
                  //   onPressed: () async {
                  //     test(context);
                  //   },
                  // ),
                  MainScreenButton(
                    buttonName: 'Tracker',
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
            ],
          ),
        ],
      ),
    );
  }
}
