import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../components/background.dart';
import 'lists/cards.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key, required this.pokemons});

  final List<Pokemon> pokemons;
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Pokemon> originalList = [];
  @override
  void initState() {
    originalList.addAll(widget.pokemons);
    super.initState();
  }

  TextEditingController editingController = TextEditingController();

  void filterSearchResults(String query) {
    List<Pokemon> dummySearchList = [];
    dummySearchList.addAll(originalList);
    if (query.isNotEmpty) {
      List<Pokemon> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        widget.pokemons.clear();
        widget.pokemons.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        widget.pokemons.clear();
        widget.pokemons.addAll(originalList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          kBasicBackground,
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    // const BackButton(color: Colors.white),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) {
                            filterSearchResults(value);
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
                Expanded(
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
                      return (widget.pokemons[index].forms.isEmpty)
                          ? singleCard(context, index, widget.pokemons)
                          : multipleCards(context, index, widget.pokemons);
                    }),
                    itemCount: widget.pokemons.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(5),
                    scrollDirection: Axis.vertical,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
