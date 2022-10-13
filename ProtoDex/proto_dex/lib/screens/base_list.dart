import 'package:flutter/material.dart';
import 'package:proto_dex/screens/details.dart';
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
    loadList();
    super.initState();
  }

  List<Pokemon> pokemons = [];
  TextEditingController editingController = TextEditingController();
  void loadList() async {
    final String rawJson = await rootBundle.loadString('data/pokedex.json');
    Iterable l = jsonDecode(rawJson);
    pokemons = List<Pokemon>.from(l.map((model) => Pokemon.fromJson(model)));
    for (var pokemon in pokemons) {
      {
        if (pokemon.forms.isNotEmpty) pokemon.forms.insert(0, pokemon);
      }
    }
    print('Number of pokemons in list');
    print(pokemons.length);

    // print(pokemons.last.forms.length);
    // // print(pokemons[0].forms[0].);

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
                itemBuilder: doubleTrouble,
                itemCount: pokemons.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget doubleTrouble(context, index) {
    final GlobalKey expansionTileKey = GlobalKey();

    void scrollToSelectedContent({required GlobalKey expansionTileKey}) {
      final keyContext = expansionTileKey.currentContext;
      if (keyContext != null) {
        Future.delayed(const Duration(milliseconds: 240)).then((value) {
          Scrollable.ensureVisible(keyContext,
              duration: const Duration(milliseconds: 200));
        });
      }
    }

    if (pokemons[index].forms.isEmpty) {
      return PokemonCard(
        pokemon: pokemons[index],
        color: Colors.black26,
      );
    } else {
      return Card(
        child: ExpansionTile(
          key: expansionTileKey,
          onExpansionChanged: (value) {
            if (value) {
              scrollToSelectedContent(expansionTileKey: expansionTileKey);
            }
          },
          collapsedBackgroundColor: Colors.black26,
          backgroundColor: Colors.black26,
          leading: ShadowImage(image: pokemons[index].image[0]),
          title: Text(pokemons[index].name),
          trailing: Text('+${pokemons[index].forms.length - 1}'),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(pokemons[index].formattedTypes()),
              Text(pokemons[index].number)
            ],
          ),
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index2) {
                return PokemonCard(pokemon: pokemons[index].forms[index2]);
              },
              itemCount: pokemons[index].forms.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
            ),
          ],
        ),
      );
    }
  }
}

class PokemonCard extends StatelessWidget {
  const PokemonCard({this.color, required this.pokemon});

  final color;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: color,
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DetailsPage(pokemon: pokemon);
              },
            ),
          )
        },
        leading: ShadowImage(image: pokemon.image[0]),
        title: Text(pokemon.name),
        trailing: const Text(''),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(pokemon.formattedTypes()), Text(pokemon.number)],
        ),
      ),
    );
  }
}

class ShadowImage extends StatelessWidget {
  const ShadowImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'images/mons/$image',
          color: Colors.black87,
          height: 51,
        ),
        Image.asset(
          'images/mons/$image',
          height: 50,
        ),
      ],
    );
  }
}
