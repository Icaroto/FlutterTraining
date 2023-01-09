import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/models/collection.dart';
import 'package:proto_dex/models/item.dart';
import 'package:proto_dex/screens/list_screen.dart';
import '../models/game.dart';

// Future<bool> createCollection(BuildContext context) async {
//   var game = await showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return genericListBuilder(Dex.availableGames(), null);
//     },
//   );

//   if (game == null) return false;
//   var dex = await showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return genericListBuilder(Dex.availableDex(game), null);
//     },
//   );

//   if (dex == null) return false;
//   var tracker = await showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return genericListBuilder(Dex.availableTrackerTypes(), null);
//     },
//   );

//   if (tracker == null) return false;
//   String collectionName = "${game}_${dex}_$tracker".replaceAll(" ", "");
//   List<Collection> collections = <Collection>[].findCollection(collectionName);
//   List<String> collectionNames = ["New..."];
//   for (var element in collections) {
//     collectionNames.add(element.type);
//   }

//   showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return genericListBuilder(
//         collectionNames,
//         () => {
//           print("Test"),

//           Navigator.pop(context, index),

//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) {
//           //       return ListScreen(
//           //         collection: retrieveCollection(
//           //           game,
//           //           dex,
//           //         ),
//           //       );
//           //     },
//           //   ),
//           // )
//         },
//       );
//     },
//   );

// Collection col = Collection.create(game, dex, TrackerTypes.basic, []);

// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) {
//       return ListScreen(
//         collection: retrieveCollection(
//           "games[index].name",
//           "",
//         ),
//       );
//     },
//   ),
// );

//   return false;
// }

ListView genericListBuilder(list, Function()? customOnTap) {
  //Function()? onTap
  return ListView.builder(
    itemBuilder: (context, index) {
      return ListTile(
        tileColor: Colors.black,
        title: Text(
          list[index],
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        onTap: (customOnTap == null)
            ? () => {
                  Navigator.pop(context, list[index]),
                }
            : customOnTap,
      );
    },
    itemCount: list.length,
    shrinkWrap: true,
    padding: const EdgeInsets.all(5),
    scrollDirection: Axis.vertical,
  );
}

enum TrackerTypes { basic, livingDex, shinyBasic, shinyLivingDex, all }

getTrackerLabel(TrackerTypes t) {
  switch (t) {
    case TrackerTypes.basic:
      return "Basic";
    case TrackerTypes.shinyBasic:
      return "Shiny Basic";
    case TrackerTypes.livingDex:
      return "Living Dex";
    case TrackerTypes.shinyLivingDex:
      return "Shiny Living Dex";
    case TrackerTypes.all:
      return "Give me a challenge";
    default:
  }
}

Future<dynamic> test(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return availableDexes();
    },
  );
}

availableDexes() {
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
                return ListScreen(
                  collection: retrieveCollection(
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

retrieveCollection(String gameName, String dexName) {
  List<Collection> collections =
      <Collection>[].findCollection("${gameName}_$dexName");

  if (collections.isEmpty) {
    List<Item> pokemons = [];
    for (var pokemon in kPokedex) {
      if (pokemon.forms.isEmpty) {
        Game? game = pokemon.findGameDex(gameName, dexName);
        if (game != null) {
          pokemons.add(Item.fromDex(pokemon, replaceNumber: game.number));
        }
      } else {
        Item? item;
        for (var form in pokemon.forms) {
          Game? game = form.findGameDex(gameName, dexName);
          if (game != null) {
            if (item == null) {
              item = Item.fromDex(form, replaceNumber: game.number);
              item.forms.add(Item.copy(item));
            } else {
              item.forms.add(Item.fromDex(form, replaceNumber: game.number));
            }
          }
        }
        if (item?.forms.length == 1) item?.forms.clear();
        if (item != null) pokemons.add(item);
      }
    }
    Collection newCollection =
        Collection.create(gameName, dexName, "", pokemons);
    newCollection.pokemons.sortBy((element) => element.number);
    collections.add(newCollection);
    collections.saveToFile("${gameName}_$dexName");
  }

  return collections.first;
}
