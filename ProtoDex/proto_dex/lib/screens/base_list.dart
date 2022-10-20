import 'package:flutter/material.dart';
import 'package:proto_dex/screens/details.dart';
import '../components/pokemon.dart';

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
                itemCount: widget.pokemons.length,
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

    if (widget.pokemons[index].forms.isEmpty) {
      return PokemonCard(
        pokemon: widget.pokemons[index],
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
          leading: ShadowImage(image: widget.pokemons[index].image[0]),
          title: Text(widget.pokemons[index].name),
          trailing: Text('+${widget.pokemons[index].forms.length - 1}'),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.pokemons[index].formattedTypes()),
              Text(widget.pokemons[index].number)
            ],
          ),
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index2) {
                return PokemonCard(
                    color: Colors.black26,
                    pokemon: widget.pokemons[index].forms[index2]);
              },
              itemCount: widget.pokemons[index].forms.length,
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
  const PokemonCard({super.key, required this.color, required this.pokemon});

  final Color color;
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
