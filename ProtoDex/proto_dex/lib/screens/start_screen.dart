import 'package:flutter/material.dart';
import 'package:proto_dex/models/collection.dart';
import '../components/background.dart';
import '../models/game.dart';
import '../models/item.dart';
import '../models/pokemon.dart';
import 'checklist_screen.dart';
import 'list_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key, required this.pokedex});

  final List<Pokemon> pokedex;

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
                            return ListScreen(pokemons: widget.pokedex);
                          },
                        ),
                      );
                    },
                  ),
                  MainScreenButton(
                    buttonName: 'Tracker',
                    imagePath: 'images/background/colored_ball.png',
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return availableDexes(widget.pokedex);
                        },
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

availableDexes(List<Pokemon> pokedex) {
  var games = Dex.availableDexes();
  return ListView.builder(
    itemBuilder: (context, index) {
      return ListTile(
        tileColor: Colors.black,
        leading: Image.asset(
          games[index].getIcon(),
          height: 40,
        ),
        title: Text(
          games[index].name,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        subtitle: Text(
          games[index].dex,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        onTap: () => {
          Navigator.pop(context),
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CheckListScreen(
                  collection: retrieveCollection(
                    pokedex,
                    games[index].name,
                    games[index].dex,
                  ),
                );
              },
            ),
          )
        },
      );
    },
    itemCount: games.length,
    shrinkWrap: true,
    padding: const EdgeInsets.all(5),
    scrollDirection: Axis.vertical,
  );
}

retrieveCollection(List<Pokemon> pokedex, String gameName, String dexName) {
  List<Collection> collections =
      <Collection>[].findCollection("${gameName}_$dexName");

  if (collections.isEmpty) {
    List<Item> pokemons = [];
    for (var pokemon in pokedex) {
      if (pokemon.forms.isEmpty) {
        Game? game = pokemon.findGameDex(gameName, dexName);
        if (game != null) {
          pokemons.add(Item.fromDex(pokemon));
        }
      } else {
        Item? item;
        for (var form in pokemon.forms) {
          Game? game = form.findGameDex(gameName, dexName);
          if (game != null) {
            if (item == null) {
              item = Item.fromDex(form);
              item.forms.add(Item.copy(item));
            } else {
              item.forms.add(Item.fromDex(form));
            }
          }
        }
        if (item?.forms.length == 1) item?.forms.clear();
        if (item != null) pokemons.add(item);
      }
    }
    Collection newCollection = Collection.create(gameName, dexName, pokemons);
    collections.add(newCollection);
    collections.saveToFile("${gameName}_$dexName");
  }

  return collections.first;
}

class MainScreenButton extends StatelessWidget {
  const MainScreenButton(
      {super.key,
      required this.buttonName,
      required this.imagePath,
      required this.onPressed});

  final String buttonName;
  final String imagePath;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF1D1E33),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 0.5,
            spreadRadius: 0.5,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Column(
          children: [
            Image.asset(imagePath, height: 100),
            Text(
              buttonName,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
