import 'package:flutter/material.dart';
import 'package:proto_dex/constants.dart';
import '../models/enums.dart';
import '../models/pokemon.dart';

class MainImage extends StatelessWidget {
  const MainImage({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: Container()),
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                //Shadow
                Center(
                  child: Image.network(
                    '${kImageLocalPrefix}mons/$imagePath',
                    color: Colors.black87,
                  ),
                ),
                //Image
                Center(
                  child: Image.network(
                    '${kImageLocalPrefix}mons/$imagePath',
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 5, child: Container())
        ],
      ),
    );
  }
}

class ListImage extends StatelessWidget {
  const ListImage({
    Key? key,
    required this.image,
    this.shadowOnly,
  }) : super(key: key);

  final String image;
  final bool? shadowOnly;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: (shadowOnly == true)
          ? [
              Image.network(
                '$kImageLocalPrefix$image',
                color: Colors.black87,
                height: 60,
              )
            ]
          : [
              Image.network(
                '$kImageLocalPrefix$image',
                color: Colors.black87,
                height: 60,
              ),
              Image.network(
                '$kImageLocalPrefix$image',
                height: 55,
              ),
            ],
    );
  }
}

class TypeIcon extends StatelessWidget {
  const TypeIcon(
      {super.key, required this.type, this.size, this.shadow = true});

  final PokemonType? type;
  final double? size;
  final bool? shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (shadow == true)
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 0.5,
                  spreadRadius: 0.5,
                  offset: Offset(2, 3),
                ),
              ],
            )
          : null,
      child: SizedBox(
        height: size,
        width: size,
        child: Pokemon.typeImage(type),
      ),
    );
  }
}
