import 'package:flutter/material.dart';
import 'package:proto_dex/constants.dart';
import '../models/item.dart';
import 'details/details_background.dart';
import 'details/basic_info.dart';
import '../components/image.dart';
import 'details/lower_screen.dart';
import '../models/pokemon.dart';

class CatchDetailsPage extends StatefulWidget {
  const CatchDetailsPage({super.key, required this.pokemon});

  final Item pokemon;

  @override
  State<CatchDetailsPage> createState() => _CatchDetailsPageState();
}

class _CatchDetailsPageState extends State<CatchDetailsPage> {
  var imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(type1: widget.pokemon.type1, type2: widget.pokemon.type2),
          AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
          BasicInfo(
            name: widget.pokemon.name,
            number: widget.pokemon.number,
            type1: widget.pokemon.type1,
            type2: widget.pokemon.type2,
          ),
          PokeInfoCard(
            myPokemon: widget.pokemon,
            pokemon: kPokedex.firstWhere(
                (element) => element.number == widget.pokemon.number),
            onImageChange: (int newIndex) {
              setState(() => imageIndex = newIndex);
            },
          ),
          MainImage(imagePath: widget.pokemon.image[imageIndex]),
        ],
      ),
    );
  }
}
