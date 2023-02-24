import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proto_dex/components/image.dart';
import 'package:proto_dex/global_settings.dart';
import 'package:proto_dex/models/game.dart';
import 'package:proto_dex/styles.dart';
import '../models/collection.dart';
import '../models/enums.dart';
import '../models/item.dart';
import '../models/pokemon.dart';
import 'lists/cards.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({
    super.key,
    this.pokemons,
    this.collection,
  });

  final List<Pokemon>? pokemons;
  final Collection? collection;
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Pokemon> originalPokedex = [];
  List<Item> filteredList = [];

  @override
  void initState() {
    if (widget.pokemons != null) originalPokedex.addAll(widget.pokemons!);
    if (widget.collection != null) {
      filteredList.addAll(widget.collection!.pokemons.toList());
    }
    super.initState();
  }

  TextEditingController editingController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void filterSearchResults(String query) {
    if (originalPokedex.isNotEmpty) {
      List<Pokemon> dummySearchList = [];
      dummySearchList.addAll(originalPokedex);
      if (query.isNotEmpty) {
        List<Pokemon> dummyListData = [];
        for (var item in dummySearchList) {
          if (item.name.toLowerCase().contains(query.toLowerCase())) {
            dummyListData.add(item);
          }
        }
        setState(() {
          widget.pokemons!.clear();
          widget.pokemons!.addAll(dummyListData);
        });
        return;
      } else {
        setState(() {
          widget.pokemons!.clear();
          widget.pokemons!.addAll(originalPokedex);
        });
      }
    } else {
      List<Item> tempList = [];
      if (query == "") {
        tempList.addAll(widget.collection!.filterCollection(FilterType.all));
      } else {
        tempList.addAll(widget.collection!
            .filterCollection(FilterType.byValue, value: query));
      }

      if (_selectedIndex != 0) {
        CaptureType capture =
            (_selectedIndex == 1) ? CaptureType.full : CaptureType.empty;
        tempList.removeWhere((element) =>
            widget.collection!.isPokemonCaptured(element) != capture &&
            widget.collection!.isPokemonCaptured(element) !=
                CaptureType.partial);
      }
      filteredList = tempList;
      setState(() {});
    }
  }

  int _selectedIndex = 0;
  bool _isSearchOpened = false;
  String _query = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: listDrawer(context),
      body: Stack(
        children: <Widget>[
          kBasicBackground,
          SafeArea(
            child: Column(
              children: [
                Visibility(
                  visible: _isSearchOpened,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            onChanged: (value) {
                              _query = value;
                              filterSearchResults(_query);
                            },
                            controller: editingController,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              labelText: "Search",
                              hintText: "Search",
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    (editingController.text == "")
                                        ? _isSearchOpened = false
                                        : editingController.clear();
                                    filterSearchResults("");
                                  });
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                giveMeAList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          (widget.pokemons == null) ? bottomNavigationBar() : null,
      appBar:
          (widget.pokemons == null) ? listAppBar(context) : dexAppBar(context),
    );
  }

  List<String> _drawerByTypesSelected = [];
  bool _exclusiveOnly = false;

  Drawer listDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 80,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: (widget.pokemons == null)
                    ? Game.gameColor(widget.collection!.game)
                    : Colors.blue,
              ),
              child: const Text('Filters'),
            ),
          ),
          const Divider(thickness: 2),
          if (widget.pokemons == null)
            Card(
              // color: Colors.lightBlue,
              shadowColor: Colors.blue,
              borderOnForeground: true,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Reveal Uncaught"),
                    ),
                    Switch(
                      // This bool value toggles the switch.
                      value: revealUncaught,
                      activeColor: Colors.red,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          revealUncaught = !revealUncaught;
                        });
                      },
                    )
                  ]),
            ),
          if (widget.pokemons == null) const Divider(thickness: 2),
          if (widget.pokemons == null)
            Card(
              // color: Colors.lightBlue,
              shadowColor: Colors.blue,
              borderOnForeground: true,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Exclusive Only"),
                    ),
                    Switch(
                      // This bool value toggles the switch.
                      value: _exclusiveOnly,
                      activeColor: Colors.red,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          _exclusiveOnly = !_exclusiveOnly;
                          if (_exclusiveOnly) {
                            filteredList = widget.collection!
                                .filterCollection(FilterType.exclusiveOnly);
                          } else {
                            filteredList = widget.collection!
                                .filterCollection(FilterType.all);
                          }
                        });
                      },
                    )
                  ]),
            ),
          if (widget.pokemons == null) const Divider(thickness: 2),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text("By Type")),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: PokemonType.values
                    .map((item) => ActionChip(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.all(1),
                          backgroundColor: Colors.white60,
                          shadowColor: Colors.blue,
                          elevation:
                              (_drawerByTypesSelected.contains(item.name))
                                  ? 5
                                  : 0,

                          onPressed: () => {
                            setState(() {
                              if (_drawerByTypesSelected.contains(item.name)) {
                                _drawerByTypesSelected.remove(item.name);
                              } else {
                                _drawerByTypesSelected.add(item.name);
                              }
                              filteredList = widget.collection!
                                  .filterCollection(FilterType.byType,
                                      values: _drawerByTypesSelected);
                            })
                          },
                          // backgroundColor: Colors.red,
                          // label: Text(item.name),
                          label: TypeIcon(
                              type: PokemonType.values.byName(item.name),
                              size: 23,
                              shadow: false),
                        ))
                    .toList()
                    .cast<Widget>(),
              ),
              Center(
                child: TextButton(
                  child: const Text("Clear"),
                  onPressed: () {
                    setState(() {
                      _drawerByTypesSelected.clear();
                      filteredList =
                          widget.collection!.filterCollection(FilterType.all);
                    });
                  },
                ),
              )
            ],
          ),
          const Divider(thickness: 2),
          Expanded(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text("Sort By")),
                ),

                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    TextButton(
                      child: const FaIcon(FontAwesomeIcons.arrowDown19),
                      onPressed: () {
                        setState(() {
                          filteredList = widget.collection!
                              .filterCollection(FilterType.numAsc);
                        });
                      },
                    ),
                    TextButton(
                      child: const FaIcon(FontAwesomeIcons.arrowDown91),
                      onPressed: () {
                        setState(() {
                          filteredList = widget.collection!
                              .filterCollection(FilterType.numDesc);
                        });
                      },
                    ),
                    TextButton(
                      child: const FaIcon(FontAwesomeIcons.arrowDownAZ),
                      onPressed: () {
                        setState(() {
                          filteredList = widget.collection!
                              .filterCollection(FilterType.nameAsc);
                        });
                      },
                    ),
                    TextButton(
                      child: const FaIcon(FontAwesomeIcons.arrowDownZA),
                      onPressed: () {
                        setState(() {
                          filteredList = widget.collection!
                              .filterCollection(FilterType.nameDesc);
                        });
                      },
                    ),
                    TextButton(
                      child: Text("Default"),
                      onPressed: () {
                        setState(() {
                          filteredList = widget.collection!
                              .filterCollection(FilterType.all);
                        });
                      },
                    ),
                  ],
                ),

                // ListView(
                //   scrollDirection: Axis.vertical,
                //   shrinkWrap: true,
                //   children: [
                //     ListTile(
                //       title: const Text('Item 2'),
                //       onTap: () {
                //         // Update the state of the app
                //         // ...
                //         // Then close the drawer
                //         Navigator.pop(context);
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          const Divider(thickness: 2),
        ],
      ),
    );
  }

  AppBar listAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          tooltip: 'Show Snackbar',
          onPressed: () {
            setState(() {
              _isSearchOpened = !_isSearchOpened;
            });
            // ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(content: Text('This is a snackbar')));
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
      ],
      backgroundColor: Game.gameColor(widget.collection!.game),
      centerTitle: true,
      title: Column(
        children: [
          Text(widget.collection!.game),
          Text("(${widget.collection!.percentage()}%)")
        ],
      ),
    );
  }

  AppBar dexAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_alt_outlined),
          onPressed: () {
            setState(() {
              scaffoldKey.currentState!.openEndDrawer();
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearchOpened = !_isSearchOpened;
            });
          },
        ),
      ],
      // backgroundColor: Game.gameColor(widget.collection!.game),
      centerTitle: true,
      title: const Text("Pokedex"),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.check_circle_outline_outlined),
          label: "All",
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.check_box_outlined),
          label: widget.collection!.capturedTotal() +
              "/" +
              widget.collection!.total(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.check_box_outline_blank),
          label: widget.collection!.missingTotal() +
              "/" +
              widget.collection!.total(),
        ),
      ],
      currentIndex: _selectedIndex,
      backgroundColor: Game.gameColor(widget.collection!.game),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      onTap: (int index) {
        setState(
          () {
            applyFilter(index);
          },
        );
      },
    );
  }

  applyFilter(int index) {
    switch (index) {
      case 0:
        filteredList = widget.collection!.filterCollection(FilterType.all);
        _selectedIndex = index;
        break;
      case 1:
        filteredList = widget.collection!.filterCollection(FilterType.captured);
        _selectedIndex = index;
        break;
      case 2:
        filteredList =
            widget.collection!.filterCollection(FilterType.notCaptured);
        _selectedIndex = index;
        break;
    }
  }

  Expanded giveMeAList() {
    return Expanded(
      child: CupertinoScrollbar(
        child: ListView.builder(
          itemBuilder: ((context, index) {
            if (widget.pokemons != null) {
              return (widget.pokemons![index].forms.isEmpty)
                  ? singleCard(
                      context,
                      index,
                      widget.pokemons,
                      () {},
                    )
                  : multipleCards(
                      context,
                      index,
                      widget.pokemons,
                      () {},
                    );
            } else {
              return (filteredList[index].forms.isEmpty)
                  ? singleCard(
                      context,
                      index,
                      filteredList,
                      () {
                        setState(() {
                          widget.collection!.updateCollection();
                          applyFilter(_selectedIndex);
                          filterSearchResults(_query);
                        });
                      },
                    )
                  : multipleCards(
                      context,
                      index,
                      filteredList,
                      () {
                        setState(() {
                          widget.collection!.updateCollection();
                          applyFilter(_selectedIndex);
                          filterSearchResults(_query);
                        });
                      },
                    );
            }
          }),
          itemCount: (widget.pokemons != null)
              ? widget.pokemons!.length
              : filteredList.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
