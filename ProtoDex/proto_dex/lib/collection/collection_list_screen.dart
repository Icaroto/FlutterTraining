import 'package:flutter/material.dart';
import 'package:proto_dex/constants.dart';
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
import 'collection_tile.dart';
import '../pokedex/pokedex_cards.dart' as dexCard;

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
    if (displayType == CollectionDisplayType.groupByPokemon) {
      groups = groupByPokemon(collection);
    } else {
      groups = groupByGame(collection);
    }

    return Expanded(
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return (displayType == CollectionDisplayType.flatList)
              ? CollectionTile(
                  pokemon: collection[index],
                  onStateChange: null,
                )
              : createCards(
                  groups[index],
                  null,
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
      // SwitchOption(
      //   title: "Reveal Uncaught",
      //   switchValue: gRevealUncaught,
      //   onSwitch: (bool value) {
      //     setState(() {
      //       gRevealUncaught = !gRevealUncaught;
      //     });
      //   },
      // ),
      // const Divider(thickness: 2),
      // SwitchOption(
      //   title: "Show Exclusive Only",
      //   switchValue: _exclusiveOnly,
      //   onSwitch: (bool value) {
      //     setState(() {
      //       _exclusiveOnly = value;
      //       (_exclusiveOnly)
      //           ? addFilter(FilterType.exclusiveOnly)
      //           : removeFilters([FilterType.exclusiveOnly]);
      //       applyFilters();
      //     });
      //   },
      // ),
      // const Divider(thickness: 2),
      // FilterByType(
      //   selectedTypes: _drawerByTypesSelected,
      //   onTypeSelected: (List<String> list) {
      //     setState(
      //       () => {
      //         _drawerByTypesSelected = list,
      //         (_drawerByTypesSelected.isEmpty)
      //             ? removeFilters([FilterType.byType])
      //             : addFilter(FilterType.byType),
      //         applyFilters(),
      //       },
      //     );
      //   },
      //   onClearPressed: () {
      //     setState(() {
      //       _drawerByTypesSelected.clear();
      //       removeFilters([FilterType.byType]);
      //       applyFilters();
      //     });
      //   },
      // ),
      // const Divider(thickness: 2),
      GroupListBy(
        currentDisplay: displayType,
        onDisplaySelected: (newDisplay) {
          setState(() {
            displayType = newDisplay;
            applyFilters();
          });
        },
      ),
      // const Divider(thickness: 2),
      // ImportToCollectionButton(
      //   listToImport: filteredList
      //       .where((element) =>
      //           widget.collection.isPokemonCaptured(element) ==
      //               CaptureType.full ||
      //           widget.collection.isPokemonCaptured(element) ==
      //               CaptureType.partial)
      //       .toList(),
      // )
    ];
  }

//This is the Second Tab Bits
  Expanded pokedex() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return dexCard.createCards(
            originalPokedex,
            [index],
            onStateChange: () {
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
}
