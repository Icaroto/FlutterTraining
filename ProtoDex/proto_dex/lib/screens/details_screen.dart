import 'package:flutter/material.dart';
import 'details/details_background.dart';
import 'details/basic_info.dart';
import '../components/image.dart';
import 'details/lower_screen.dart';
import '../models/pokemon.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(type1: widget.pokemon.type1, type2: widget.pokemon.type2),
          AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
          BasicInfo(pokemon: widget.pokemon),
          PokeInfoCard(
            pokemon: widget.pokemon,
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
