import 'package:flutter/material.dart';
import '../components/background.dart';
import '../components/basic_info.dart';
import '../components/image_container.dart';
import '../components/info_tab.dart';
import '../components/pokemon.dart';

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
            imageIndex: imageIndex,
            onImageChange: (int newIndex) {
              setState(() => imageIndex = newIndex);
            },
          ),
          PokeImage(imagePath: widget.pokemon.image[imageIndex]),
        ],
      ),
    );
  }
}
