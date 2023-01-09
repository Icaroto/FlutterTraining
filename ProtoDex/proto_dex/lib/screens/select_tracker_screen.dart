import 'package:flutter/material.dart';
import 'package:proto_dex/components/main_button.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/styles.dart';
import '../models/collection.dart';
import '../models/game.dart';
import 'list_screen.dart';

class SelectTrackerScreen extends StatefulWidget {
  const SelectTrackerScreen({super.key});

  @override
  State<SelectTrackerScreen> createState() => _SelectTrackerScreenState();
}

class _SelectTrackerScreenState extends State<SelectTrackerScreen> {
  @override
  void initState() {
    super.initState();
  }

  String gamePicked = "";
  String dexPicked = "";
  String trackerPicked = "";
  List<String> gamesAvailable = Dex.availableGames();
  List<String> dexAvailable = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          kBasicBackground,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 150.0,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  ),
                  itemBuilder: ((context, index) {
                    return MainScreenButton(
                      buttonName: gamesAvailable[index],
                      imagePath: 'images/background/colored_ball.png',
                      onPressed: () => {
                        setState(() {
                          gamePicked = gamesAvailable[index];
                          dexAvailable = Dex.availableDex(gamePicked);
                          print("FROM GAME");
                          print(gamePicked);
                        })
                      },
                    );
                  }),
                  itemCount: gamesAvailable.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: 150.0,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  ),
                  itemBuilder: ((context, index2) {
                    if (gamePicked != "") {
                      return MainScreenButton(
                        buttonName: dexAvailable[index2],
                        imagePath: 'images/background/colored_ball.png',
                        onPressed: () => {
                          setState(() {
                            dexPicked = dexAvailable[index2];
                            print("FROM DEX");
                            print(gamePicked);
                          })
                        },
                      );
                    } else {
                      return Container();
                    }
                  }),
                  itemCount: dexAvailable.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainScreenButton(
                    buttonName: 'Base',
                    imagePath: 'images/background/colored_ball.png',
                    onPressed: () => {
                      trackerPicked = "Base",
                      print("FROM TRACKER"),
                      print(gamePicked),
                    },
                  ),
                  MainScreenButton(
                    buttonName: 'Shiny',
                    imagePath: 'images/background/colored_ball.png',
                    onPressed: () => {
                      trackerPicked = "Shiny",
                      print("FROM TRACKER"),
                      print(gamePicked),
                    },
                  ),
                  MainScreenButton(
                    buttonName: 'Living Dex',
                    imagePath: 'images/background/colored_ball.png',
                    onPressed: () => {
                      trackerPicked = "Living Dex",
                      print("FROM TRACKER"),
                      print(gamePicked),
                    },
                  ),
                ],
              ),
              (gamePicked != "" && dexPicked != "")
                  ? TextButton(
                      onPressed: () => {
                        print(gamePicked),
                        print(dexPicked),
                        print(trackerPicked)
                      },
                      child: Text("START TRACKING"),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
