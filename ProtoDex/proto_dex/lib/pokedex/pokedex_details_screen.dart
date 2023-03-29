import 'package:flutter/material.dart';
import '../models/tab.dart';
import '../screens/details/breeding_card.dart';
import '../screens/details/details_background.dart';
import '../screens/details/basic_info.dart';
import '../components/image.dart';
import '../screens/details/games_card.dart';
import '../screens/details/general_card.dart';
import '../components/tab.dart';
import '../models/pokemon.dart';
import '../screens/details/weakness_card.dart';

class PokedexDetailsPage extends StatefulWidget {
  const PokedexDetailsPage(
      {super.key, required this.pokemons, required this.indexes});

  final List<Pokemon> pokemons;
  final List<int> indexes;

  @override
  State<PokedexDetailsPage> createState() => _PokedexDetailsPage();
}

class _PokedexDetailsPage extends State<PokedexDetailsPage> {
  int imageIndex = 0;
  bool isFirstInList = false;
  bool isLastInList = false;
  List<int> currentIndexes = List<int>.empty(growable: true);

  @override
  void initState() {
    currentIndexes.addAll(widget.indexes);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isFirstInList = widget.pokemons.isFirst(currentIndexes);
    isLastInList = widget.pokemons.isLast(currentIndexes);

    Pokemon pokemon = widget.pokemons.current(currentIndexes);

    return Scaffold(
      body: Stack(
        children: [
          Background(type1: pokemon.type1, type2: pokemon.type2),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          BasicInfo(
            name: pokemon.name,
            number: pokemon.number,
            type1: pokemon.type1,
            type2: pokemon.type2,
          ),
          TabControl(tabs: buildTab(pokemon)),
          WillPopScope(
              onWillPop: () async {
                imageIndex = 0;
                Navigator.pop(context, false);
                return false;
              },
              child: IgnorePointer(
                  child: MainImage(imagePath: pokemon.image[imageIndex]))),
          navigationButtons(pokemon),
        ],
      ),
    );
  }

  Center navigationButtons(Pokemon pokemon) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (isFirstInList)
                  ? null
                  : () => {
                        setState(() {
                          imageIndex = 0;
                          pokemon.resetImage();
                          currentIndexes =
                              widget.pokemons.previousIndex(currentIndexes);
                        }),
                      },
              child: (isFirstInList)
                  ? Container()
                  : const Icon(
                      Icons.keyboard_arrow_left,
                      size: 30,
                      color: Colors.black,
                    ),
            ),
            GestureDetector(
              onTap: (isLastInList)
                  ? null
                  : () => {
                        setState(() {
                          imageIndex = 0;
                          pokemon.resetImage();
                          currentIndexes =
                              widget.pokemons.nextIndex(currentIndexes);
                        }),
                      },
              child: (isLastInList)
                  ? Container()
                  : const Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                      color: Colors.black,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  buildTab(Pokemon pokemon) {
    List<PokeTab> tabs = [];
    tabs.add(
      PokeTab(
        tabName: "About",
        leftCard: GeneralInformationCard(
          pokemon: pokemon,
          onImageChange: (int newIndex) {
            setState(() => imageIndex = newIndex);
          },
        ),
        rightCard: BreedingInformationCard(
          pokemon: pokemon,
          onImageChange: (int newIndex) {
            setState(() => imageIndex = newIndex);
          },
        ),
      ),
    );

    tabs.add(PokeTab(
      tabName: "More",
      leftCard: GamesInformationCard(pokemon: pokemon),
      rightCard: WeaknessInformationCard(pokemon: pokemon),
    ));

    return tabs;
  }
}
