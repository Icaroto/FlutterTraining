import 'package:flutter/material.dart';
import '../components/pokemon.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ListScreen extends StatefulWidget {
  // ListScreen({required this.pokemons});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
    loadList();
  }

  List<Pokemon> pokemons = [];
  TextEditingController editingController = TextEditingController();
  void loadList() async {
    final String rawJson = await rootBundle.loadString('data/pokedex.json');
    Iterable l = jsonDecode(rawJson);
    pokemons = List<Pokemon>.from(l.map((model) => Pokemon.fromJson(model)));

    print('Number of pokemons in list');
    print(pokemons.length);
    setState(() {});
  }

  void filterSearchResults(String query) {
    List<Pokemon> dummySearchList = [];
    dummySearchList.addAll(pokemons);
    if (query.isNotEmpty) {
      List<Pokemon> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        pokemons.clear();
        pokemons.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        pokemons.clear();
        loadList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  // return Card(
                  //   child: Expanded(
                  //     child: Row(
                  //       children: [
                  //         Image.asset(pokemons[index].image),
                  //         Text(pokemons[index].name),
                  //         Text(pokemons[index].type1.name),
                  //         // Text((pokemons[index].type2?.name ?? '')),
                  //       ],
                  //     ),
                  //   ),
                  // );
                  return Card(
                    child: ListTile(
                      tileColor: Colors.black26,
                      onTap: () => print('test'),
                      leading: Image.asset(pokemons[index].image),
                      title: Text(pokemons[index].name),
                      subtitle: Row(
                        children: [
                          Text(pokemons[index].type1.name),
                          Text('/'),
                          Text(pokemons[index].type2?.name ?? '-'),
                        ],
                      ),
                      trailing: Checkbox(
                          onChanged: (value) => print('this is the checkbox'),
                          value: true),
                    ),
                  );
                },
                itemCount: pokemons.length,
                shrinkWrap: true,
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
