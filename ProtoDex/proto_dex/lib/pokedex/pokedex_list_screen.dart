import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proto_dex/components/image.dart';
import 'package:proto_dex/pokedex/pokedex_cards.dart';
import 'package:proto_dex/styles.dart';
import '../models/enums.dart';
import '../models/pokemon.dart';

class PokedexListScreen extends StatefulWidget {
  const PokedexListScreen({
    super.key,
    required this.pokemons,
  });

  final List<Pokemon> pokemons;
  @override
  State<PokedexListScreen> createState() => _PokedexListScreenState();
}

class _PokedexListScreenState extends State<PokedexListScreen> {
  List<Pokemon> originalPokedex = [];
  List<FilterType> filters = [];
  String _query = "";
  bool _isSearchOpened = false;
  final List<String> _drawerByTypesSelected = [];
  TextEditingController editingController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    originalPokedex.addAll(widget.pokemons);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appTopBar(context),
      endDrawer: rightDrawer(context),
      body: Stack(
        children: <Widget>[
          kBasicBackground,
          SafeArea(
            child: Column(
              children: [
                searchBar(),
                list(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void applyFilters() {
    setState(() {
      (_query == "")
          ? removeFilters([FilterType.byValue])
          : addFilter(FilterType.byValue);
      originalPokedex = widget.pokemons
          .applyAllFilters(filters, _query, _drawerByTypesSelected);
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

  Visibility searchBar() {
    return Visibility(
      visible: _isSearchOpened,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                autofocus: true,
                onChanged: (value) {
                  _query = value;
                  applyFilters();
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
                        _query = "";
                        applyFilters();
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.white),
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
    );
  }

  Drawer rightDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 80,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Filters'),
            ),
          ),
          const Divider(thickness: 2),
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

                              (_drawerByTypesSelected.isEmpty)
                                  ? removeFilters([FilterType.byType])
                                  : addFilter(FilterType.byType);

                              applyFilters();
                            })
                          },
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
                      removeFilters([FilterType.byType]);
                      applyFilters();
                    });
                  },
                ),
              )
            ],
          ),
          const Divider(thickness: 2),
          Column(
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
                        addFilter(FilterType.numAsc);

                        removeFilters([
                          FilterType.numDesc,
                          FilterType.nameAsc,
                          FilterType.nameDesc
                        ]);

                        applyFilters();
                      });
                    },
                  ),
                  TextButton(
                    child: const FaIcon(FontAwesomeIcons.arrowDown91),
                    onPressed: () {
                      setState(() {
                        addFilter(FilterType.numDesc);

                        removeFilters([
                          FilterType.numAsc,
                          FilterType.nameAsc,
                          FilterType.nameDesc
                        ]);

                        applyFilters();
                      });
                    },
                  ),
                  TextButton(
                    child: const FaIcon(FontAwesomeIcons.arrowDownAZ),
                    onPressed: () {
                      setState(() {
                        addFilter(FilterType.nameAsc);

                        removeFilters([
                          FilterType.numAsc,
                          FilterType.numDesc,
                          FilterType.nameDesc
                        ]);

                        applyFilters();
                      });
                    },
                  ),
                  TextButton(
                    child: const FaIcon(FontAwesomeIcons.arrowDownZA),
                    onPressed: () {
                      setState(() {
                        addFilter(FilterType.nameDesc);

                        removeFilters([
                          FilterType.numAsc,
                          FilterType.numDesc,
                          FilterType.nameAsc
                        ]);

                        applyFilters();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const Divider(thickness: 2),
          Center(
            child: TextButton(
              child: const Text("Close"),
              onPressed: () {
                setState(() {
                  scaffoldKey.currentState!.closeEndDrawer();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar appTopBar(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            // tooltip: 'Show Snackbar',
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
        centerTitle: true,
        title: const Text("Pokedex"));
  }

  Expanded list() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return (originalPokedex[index].forms.isEmpty)
              ? singleCard(
                  originalPokedex,
                  [index],
                )
              : multipleCards(
                  originalPokedex,
                  [index],
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
