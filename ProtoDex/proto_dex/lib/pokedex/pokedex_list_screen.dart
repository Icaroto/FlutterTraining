import 'package:flutter/material.dart';
import 'package:proto_dex/pokedex/pokedex_cards.dart';
import 'package:proto_dex/styles.dart';
import '../components/app_bar.dart';
import '../components/filters_drawer.dart';
import '../components/search_bar.dart';
import '../components/filter_by_type.dart';
import '../components/sort_list_by.dart';
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

  List<String> _drawerByTypesSelected = [];
  bool _isSearchOpened = false;
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
      appBar: AppBarBase(
        title: const Text("Pokedex"),
        actions: pokedexActions(),
      ),
      endDrawer: FiltersSideScren(
        filters: pokedexFilters(),
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
                listBuild(),
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

  List<Widget> pokedexFilters() {
    return [
      const Divider(thickness: 2),
      FilterByType(
        selectedTypes: _drawerByTypesSelected,
        onTypeSelected: (List<String> list) {
          setState(
            () => {
              _drawerByTypesSelected = list,
              (_drawerByTypesSelected.isEmpty)
                  ? removeFilters([FilterType.byType])
                  : addFilter(FilterType.byType),
              applyFilters(),
            },
          );
        },
        onClearPressed: () {
          setState(() {
            _drawerByTypesSelected.clear();
            removeFilters([FilterType.byType]);
            applyFilters();
          });
        },
      ),
      const Divider(thickness: 2),
      SortListBy(
        onFilterSelected: (filter) {
          setState(() {
            removeFilters([
              FilterType.numAsc,
              FilterType.numDesc,
              FilterType.nameAsc,
              FilterType.nameDesc
            ]);
            addFilter(filter);
            applyFilters();
          });
        },
      ),
    ];
  }

  List<Widget> pokedexActions() {
    return [
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
    ];
  }

  Expanded listBuild() {
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