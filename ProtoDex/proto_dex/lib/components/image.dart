import 'package:flutter/material.dart';
import '../models/enums.dart';
import '../models/pokemon.dart';

String imageLocalPrefix =
    "https://raw.githubusercontent.com/Icaroto/FlutterTraining/main/ProtoDex/Art/";

class MainImage extends StatelessWidget {
  const MainImage({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 2, child: Container()),
        Stack(
          children: [
            //Shadow
            Center(
              child: Image.network(
                '${imageLocalPrefix}mons/$imagePath',
                height: 305,
                color: Colors.black87,
              ),
            ),
            //Image
            Center(
              child: Image.network('${imageLocalPrefix}mons/$imagePath',
                  height: 300),
            ),
          ],
        ),
        Expanded(flex: 5, child: Container())
      ],
    );
  }
}

class ListImage extends StatelessWidget {
  const ListImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          '${imageLocalPrefix}mons/$image',
          color: Colors.black87,
          height: 60,
        ),
        Image.network(
          '${imageLocalPrefix}mons/$image',
          height: 55,
        ),
      ],
    );
  }
}

class TypeIcon extends StatelessWidget {
  const TypeIcon({super.key, required this.type, this.size});

  final PokemonType? type;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.5,
            spreadRadius: 0.5,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: SizedBox(
        height: size,
        width: size,
        child: Pokemon.typeImage(type),
      ),
    );
  }
}
