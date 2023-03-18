import 'package:flutter/material.dart';
import '../../models/tab.dart';
import '../details/breeding_card.dart';
import '../details/details_background.dart';
import '../details/basic_info.dart';
import '../../components/image.dart';
import '../details/games_card.dart';
import '../details/general_card.dart';
import '../details/lower_screen.dart';
import '../../models/pokemon.dart';
import '../details/weakness_card.dart';

class PokedexDetailsPage extends StatefulWidget {
  const PokedexDetailsPage(
      {super.key, required this.pokemons, required this.index});

  final List<Pokemon> pokemons;
  final int index;

  @override
  State<PokedexDetailsPage> createState() => _PokedexDetailsPage();
}

class _PokedexDetailsPage extends State<PokedexDetailsPage> {
  var imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Pokemon displayPokemon = widget.pokemons[widget.index];

    return Scaffold(
      body: Stack(
        children: [
          Background(type1: displayPokemon.type1, type2: displayPokemon.type2),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          BasicInfo(
            name: displayPokemon.name,
            number: displayPokemon.number,
            type1: displayPokemon.type1,
            type2: displayPokemon.type2,
          ),
          TabControl(tabs: giveMeATab(displayPokemon)),
          WillPopScope(
              onWillPop: () async {
                displayPokemon.resetImage();
                Navigator.pop(context, false);
                return false;
              },
              child: MainImage(imagePath: displayPokemon.image[imageIndex])),
        ],
      ),
    );
  }

  giveMeATab(displayPokemon) {
    List<PokeTab> tabs = [];
    tabs.add(
      PokeTab(
        tabName: "General",
        leftCard: GeneralInformationCard(
          pokemon: displayPokemon,
          onImageChange: (int newIndex) {
            setState(() => imageIndex = newIndex);
          },
        ),
        rightCard: BreedingInformationCard(
          pokemon: displayPokemon,
          onImageChange: (int newIndex) {
            setState(() => imageIndex = newIndex);
          },
        ),
      ),
    );

    tabs.add(PokeTab(
      tabName: "More",
      leftCard: GamesInformationCard(pokemon: displayPokemon),
      rightCard: WeaknessInformationCard(pokemon: displayPokemon),
    ));

    return tabs;
  }
}
