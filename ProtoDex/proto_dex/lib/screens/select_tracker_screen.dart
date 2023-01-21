import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/models/enums.dart';
import 'package:proto_dex/styles.dart';
import '../models/collection.dart';
import '../models/game.dart';
import '../models/item.dart';
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
  List<String> trackers = Dex.availableTrackerTypes();
  List<String> dexAvailable = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trackers"),
      ),
      body: Stack(
        children: <Widget>[
          kBasicBackground,
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "GAMES",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: gamesAvailable.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2.5),
                                    child: TrackerButton(
                                        buttonName: gamesAvailable[index],
                                        imagePath:
                                            'images/background/colored_ball.png',
                                        onPressed: (() => {
                                              setState(() {
                                                gamePicked =
                                                    gamesAvailable[index];
                                                dexAvailable = Dex.availableDex(
                                                    gamePicked);
                                                dexPicked = "";
                                              })
                                            }),
                                        isPicked: (gamePicked ==
                                            gamesAvailable[index])),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "DEX",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: dexAvailable.length,
                              itemBuilder: (BuildContext context, int index2) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.5),
                                  child: TrackerButton(
                                      buttonName: dexAvailable[index2],
                                      imagePath: '',
                                      onPressed: (() => {
                                            setState(() {
                                              dexPicked = dexAvailable[index2];
                                            })
                                          }),
                                      isPicked:
                                          (dexPicked == dexAvailable[index2])),
                                );
                              },
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "TRACKERS",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: trackers.length,
                                itemBuilder:
                                    (BuildContext context, int index3) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2.5),
                                    child: TrackerButton(
                                        buttonName: trackers[index3],
                                        imagePath: '',
                                        onPressed: (() => {
                                              setState(() {
                                                trackerPicked =
                                                    trackers[index3];
                                              })
                                            }),
                                        isPicked: (trackerPicked ==
                                            trackers[index3])),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "RECENT TRACKERS",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Expanded(
                              child: FutureBuilder(
                                future: <Collection>[].findCollections(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Collection>> snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      itemCount: snapshot.data?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(2.5),
                                          child: TrackerButton(
                                              buttonName:
                                                  snapshot.data![index].name,
                                              imagePath: '',
                                              onPressed: (() => {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return ListScreen(
                                                              collection: retrieveCollection(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .game,
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .dex,
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .type));
                                                        },
                                                      ),
                                                    ),
                                                  }),
                                              isPicked: false),
                                        );
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("Error: ${snapshot.error}");
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CircularProgressIndicator(),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => {
                    if (gamePicked != "" &&
                        dexPicked != "" &&
                        trackerPicked != "")
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ListScreen(
                                  collection: retrieveCollection(
                                      gamePicked, dexPicked, trackerPicked));
                            },
                          ),
                        ),
                      }
                  },
                  child: const Text("START TRACKING!"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TrackerButton extends StatelessWidget {
  const TrackerButton(
      {super.key,
      required this.buttonName,
      required this.imagePath,
      required this.onPressed,
      required this.isPicked});

  final String buttonName;
  final String imagePath;
  final Function()? onPressed;
  final bool isPicked;

  @override
  Widget build(BuildContext context) {
    Color color = (isPicked) ? Colors.blue : Colors.grey;
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 0.5,
            spreadRadius: 0.5,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: SizedBox(
        height: 30,
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (imagePath != "") Image.asset(imagePath, scale: 2),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    buttonName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: color),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Collection retrieveCollection(
    String gameName, String dexName, String trackerType) {
  String collectionName = "tracker_${gameName}_${dexName}_$trackerType"
      .replaceAll(" ", "")
      .replaceAll("'", "")
      .toLowerCase();

  List<Collection> collections = <Collection>[].findCollection(collectionName);

  if (collections.isEmpty) {
    Collection collection = createColletion(gameName, dexName, trackerType);
    collections.add(collection);
    collections.saveToFile(collectionName);
  }

  return collections.first;
}

createColletion(String gameName, String dexName, String trackerType) {
  List<Item> pokemons = [];
  for (var pokemon in kPokedex) {
    Item? item;
    if (pokemon.forms.isEmpty) {
      Game? game = pokemon.findGameDex(gameName, dexName);
      if (game != null) {
        if (trackerType.contains("Shiny") && game.shinyLocked == "UNLOCKED") {
          item = Item.fromDex(pokemon, game, useGameDexNumber: true);
        } else {
          item = Item.fromDex(pokemon, game, useGameDexNumber: true);
        }
        // pokemons.add(poke);
      }
    } else {
      for (var form in pokemon.forms) {
        Game? game = form.findGameDex(gameName, dexName);
        if (game != null) {
          if (trackerType.contains("Shiny") && game.shinyLocked == "UNLOCKED") {
            //if no form has been added yet
            //first form becomes base
            if (item == null) {
              item = Item.fromDex(form, game, useGameDexNumber: true);
              item.forms.add(Item.copy(item));
            } else {
              item.forms.add(Item.fromDex(form, game, useGameDexNumber: true));
            }
          } else {
            if (item == null) {
              item = Item.fromDex(form, game, useGameDexNumber: true);
              item.forms.add(Item.copy(item));
            } else {
              item.forms.add(Item.fromDex(form, game, useGameDexNumber: true));
            }
          }
        }
      }
    }
    if (item?.forms.length == 1) item?.forms.clear();

    if (item != null) {
      if (trackerType.contains("Shiny")) {
        item.displayImage =
            item.image.firstWhere((img) => img.contains("-shiny-"));
        item.forms.forEach((form) {
          form.displayImage =
              form.image.firstWhere((img) => img.contains("-shiny-"));
        });
      }

      if (trackerType.contains("Living")) {
        if (item.hasGenderDiff()) {
          if (item.name != "Oinkologne" && item.name != "Indeedee") {
            String variant =
                (trackerType.contains("Shiny")) ? "-shiny-" : "-normal-";

            Item female = Item.copy(item);
            female.gender = PokemonGender.female;
            female.displayImage = item.image.firstWhere(
                (img) => img.contains("-f.") && img.contains(variant));

            Item male = Item.copy(item);
            male.gender = PokemonGender.male;
            male.displayImage = item.image.firstWhere(
                (img) => img.contains("-m.") && img.contains(variant));

            item.forms.insert(0, male);
            item.forms.insert(1, female);
          }
        }
      } else {
        item.forms.clear();
      }

      pokemons.add(item);
    }
  }

  Collection collection =
      Collection.create(gameName, dexName, trackerType, pokemons);

  collection.pokemons.sortBy((element) => element.number);

  return collection;
}
