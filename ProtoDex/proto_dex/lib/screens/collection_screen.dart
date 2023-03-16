import 'package:flutter/material.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/styles.dart';
import '../models/group.dart';
import '../models/item.dart';
import '../models/pokemon.dart';
import '../utils/collection_manager.dart';
import 'lists/cards.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({
    super.key,
  });

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  List<Pokemon> originalPokedex = [];
  int _selectedIndex = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<Item> collection = List<Item>.empty(growable: true);
  @override
  void initState() {
    originalPokedex.addAll(kPokedex);
    collection = getCollection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appTopBar(context),
      // endDrawer: rightDrawer(context),
      body: Stack(
        children: <Widget>[
          kBasicBackground,
          SafeArea(
            child: Column(
              children: [
                if (_selectedIndex == 0 && collection.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "You have no mons in your collection",
                        style: TextStyle(color: Colors.yellow, fontSize: 15),
                      ),
                    ),
                  ),
                if (_selectedIndex == 0 && collection.isNotEmpty)
                  collectionList(),
                if (_selectedIndex == 1) pokedex()
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Expanded collectionList() {
    // List<Group> groups = createGroupByPokemon(collection);
    List<Group> groups = createGroupByGame(collection);

    return Expanded(
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return collectionCard(
            context,
            groups[index],
            () {},
          );
        }),
        itemCount: groups.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      ),
    );
  }
  // Expanded collectionList() {
  //   return Expanded(
  //     child: ListView.builder(
  //       itemBuilder: ((context, index) {
  //         return collectionCard(
  //           context,
  //           index,
  //           collection,
  //           () {},
  //         );
  //       }),
  //       itemCount: collection.length,
  //       shrinkWrap: true,
  //       padding: const EdgeInsets.all(5),
  //       scrollDirection: Axis.vertical,
  //     ),
  //   );
  // }

  Expanded pokedex() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return (originalPokedex[index].forms.isEmpty)
              ? singleCard(
                  context,
                  index,
                  originalPokedex,
                  () {
                    setState(() {
                      // collection.add(
                      //   Item.fromDex(
                      //     originalPokedex[index],
                      //     Game(
                      //         name: "otro",
                      //         dex: "otro",
                      //         number: "1",
                      //         notes: "",
                      //         shinyLocked: "false"),
                      //   ),
                      // );
                      saveCollection(collection);
                      // applyFilters();
                    });
                  },
                )
              : multipleCards(
                  context,
                  index,
                  originalPokedex,
                  () {
                    setState(() {
                      // collection.add(
                      //   Item.fromDex(
                      //     originalPokedex[index],
                      //     Game(
                      //         name: "otro",
                      //         dex: "otro",
                      //         number: "1",
                      //         notes: "",
                      //         shinyLocked: "false"),
                      //   ),
                      // );
                      saveCollection(collection);
                      // applyFilters();
                    });
                  },
                );
        }),
        itemCount: originalPokedex.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  AppBar appTopBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: const Text("Collection"),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle_outline_outlined),
          label: "Collection",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: "Add",
        ),
      ],
      currentIndex: _selectedIndex,
      backgroundColor: Colors.blue,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      onTap: (int index) {
        setState(
          () {
            _selectedIndex = index;
          },
        );
      },
    );
  }

  // groupByPokemon() {
  //   var newMap = groupBy(collection, (Item obj) => obj.natDexNumber);
  //   newMap.forEach((key, value) {
  //     print(key);
  //     print(value.first.);
  //   });
  // }
}
