import 'package:flutter/material.dart';
import 'package:proto_dex/styles.dart';

import '../constants.dart';

class MainScreenButton extends StatelessWidget {
  const MainScreenButton(
      {super.key,
      required this.buttonName,
      required this.imagePath,
      required this.onPressed});

  final String buttonName;
  final String imagePath;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: containerBoxDecoration,
      child: TextButton(
        onPressed: onPressed,
        child: Column(
          children: [
            // Image.asset("images/$imagePath", height: 100),
            Image.network(kImageLocalPrefix + imagePath, height: 100),
            SizedBox(
              width: 100,
              child: FittedBox(
                child: Text(
                  buttonName,
                  style: buttonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
