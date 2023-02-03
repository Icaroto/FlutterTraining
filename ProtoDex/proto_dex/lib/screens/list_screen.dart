import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proto_dex/models/game.dart';
import 'package:proto_dex/styles.dart';
import '../models/collection.dart';
import '../models/item.dart';
import '../models/pokemon.dart';
import 'lists/cards.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key, this.pokemons, this.collection});

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
      appBar: (widget.pokemons == null) ? listAppBar(context) : null,
    );
  }

  AppBar listAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_alt_sharp),
          tooltip: 'Show Snackbar',
          onPressed: () {
            setState(() {
              _isSearchOpened = !_isSearchOpened;
            });
            // ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(content: Text('This is a snackbar')));
          },
        ),
      ],
      backgroundColor: Game.gameColor(widget.collection!.game),
      title: Center(
        child: Column(
          children: [
            Text(widget.collection!.game),
            Text("(${widget.collection!.percentage()}%)")
          ],
        ),
      ),
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
