import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class PokeImage extends StatelessWidget {
  const PokeImage({
    Key? key,
  }) : super(key: key);

  final String imagePath = 'images/mons/bubs.png';
//TODO: Bring the url from the image to be used here
//Make sure to keep the second image disabled until the pokemon is caught
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
              child: Image.asset(
                imagePath,
                height: 235,
                color: Colors.black87,
              ),
            ),
            //Image
            Center(
              child: Image.asset(imagePath, height: 230),
            ),
          ],
        ),
        Expanded(flex: 3, child: Container())
      ],
    );
  }
}
