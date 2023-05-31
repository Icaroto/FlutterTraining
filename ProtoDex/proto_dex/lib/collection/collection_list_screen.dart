import 'package:flutter/material.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/models/game.dart';
import 'package:proto_dex/styles.dart';
import '../components/app_bar.dart';
import '../components/filters_side_screen.dart';
import '../components/group_list_by.dart';
import '../components/search_bar.dart';
import '../models/enums.dart';
import '../models/group.dart';
import '../models/item.dart';
import '../models/pokemon.dart';
import '../utils/collection_manager.dart';
import 'collection_cards.dart';
import 'collection_details_screen.dart';
import 'collection_tile.dart';
import '../pokedex/pokedex_cards.dart' as dex_card;

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({
    super.key,
  });

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  String _query = "";
  int _selectedTab = 0;
  bool _isSearchOpened = false;
  CollectionDisplayType displayType = CollectionDisplayType.flatList;
  List<Item> collection = List<Item>.empty(growable: true);
  List<Pokemon> originalPokedex = [];
  List<FilterType> filters = [];
  TextEditingController editingController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
      appBar: AppBarBase(
        title: const Text("My Collection"),
        actions: appBarActions(),
      ),
      endDrawer: FiltersSideScreen(
        filters: trackerFilters(),
        onClose: () {
          setState(() => scaffoldKey.currentState!.closeEndDrawer());
        },
      ),
      body: Stack(
        children: <Widget>[
          kBasicBackground,
          SafeArea(
            child: Column(
              children: [
                SearchBar(
                  isSearchOpened: _isSearchOpened,
                  editingController: editingController,
                  onCloseTap: () => {
                    setState(
                      () {
                        (editingController.text == "")
                            ? _isSearchOpened = false
                            : editingController.clear();
                        _query = "";
                        applyFilters();
                      },
                    )
                  },
                  onValueChange: (value) {
                    _query = value;
                    applyFilters();
                  },
                ),
                if (_selectedTab == 0 && collection.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "You have no mons in your collection",
                        style: TextStyle(color: Colors.yellow, fontSize: 15),
                      ),
                    ),
                  ),
                if (_selectedTab == 0 && collection.isNotEmpty)
                  collectionList(),
                if (_selectedTab == 1) pokedex()
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedTab,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        onTap: (int index) {
          setState(
            () {
              _selectedTab = index;
            },
          );
        },
      ),
    );
  }

  Expanded collectionList() {
    List<Group> groups;
    switch (displayType) {
      case CollectionDisplayType.groupByCurrentGame:
        groups = groupByCurrentGame(collection);
        break;
      case CollectionDisplayType.groupByOriginalGame:
        groups = groupByOriginGame(collection);
        break;
      case CollectionDisplayType.groupByPokemon:
      default:
        groups = groupByPokemon(collection);
        break;
    }

    return Expanded(
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return (displayType == CollectionDisplayType.flatList)
              ? CollectionTile(
                  pokemons: collection,
                  indexes: [index],
                  onStateChange: () {
                    setState(() {
                      saveCollection(collection);
                    });
                  },
                  onDelete: (item) {
                    setState(() {
                      removeFromColletion(item);
                    });
                  },
                )
              : createCards(
                  groups[index],
                  onStateChange: () {
                    setState(() {
                      saveCollection(collection);
                    });
                  },
                  onDelete: (item) {
                    setState(() {
                      removeFromColletion(item);
                    });
                  },
                );
        }),
        itemCount: (CollectionDisplayType.flatList == displayType)
            ? collection.length
            : groups.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  void removeFromColletion(item) {
    collection.remove(item);
    saveCollection(collection);
  }

  void applyFilters() {
    setState(() {
      (_query == "")
          ? removeFilters([FilterType.byValue])
          : addFilter(FilterType.byValue);

      collection = getCollection();
      collection = collection.applyAllFilters(filters, _query);
    });
  }

  void addFilter(FilterType filter) {
    if (!filters.contains(filter)) filters.add(filter);
  }

  void removeFilters(List<FilterType> filtersToRemove) {
    for (var element in filtersToRemove) {
      filters.remove(element);
    }
  }

  List<Widget> appBarActions() {
    return [
      IconButton(
        icon: const Icon(Icons.search_outlined),
        onPressed: () {
          setState(() {
            _isSearchOpened = !_isSearchOpened;
          });
        },
      ),
      IconButton(
        icon: const Icon(Icons.filter_alt_outlined),
        onPressed: () {
          setState(() {
            scaffoldKey.currentState!.openEndDrawer();
          });
        },
      ),
    ];
  }

  List<Widget> trackerFilters() {
    return [
      const Divider(thickness: 2),
      GroupListBy(
        currentDisplay: displayType,
        onDisplaySelected: (newDisplay) {
          setState(() {
            displayType = newDisplay;
            applyFilters();
          });
        },
      ),
    ];
  }

//This is the Second Tab Bits
  Expanded pokedex() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return dex_card.createCards(
            originalPokedex,
            [index],
            onStateChange: (indexes) {
              List<Item> items = [createItem(originalPokedex, indexes)];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CollectionDetailsPage(
                      pokemons: items,
                      indexes: const [0],
                      onStateChange: () {
                        collection.add(items.first);
                        saveCollection(collection);
                      },
                    );
                  },
                ),
              );
              setState(() {
                () => {};
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

  Item createItem(List<Pokemon> pokemons, List<int> indexes) {
    Pokemon pokemon = pokemons.current(indexes);
    Game tempGame =
        Game(name: "", dex: "", number: "", notes: "", shinyLocked: "");
    Item item = Item.fromDex(pokemon, tempGame, kCollectionBaseName);
    item.catchDate = DateTime.now().toString();
    return item;
  }
}
