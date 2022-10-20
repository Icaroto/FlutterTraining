import 'package:flutter/material.dart';

class PokeImage extends StatelessWidget {
  const PokeImage({Key? key, required this.imagePath}) : super(key: key);

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
              child: Image.asset(
                'images/mons/$imagePath',
                height: 235,
                color: Colors.black87,
              ),
            ),
            //Image
            Center(
              child: Image.asset('images/mons/$imagePath', height: 230),
            ),
          ],
        ),
        Expanded(flex: 3, child: Container())
      ],
    );
  }
}
