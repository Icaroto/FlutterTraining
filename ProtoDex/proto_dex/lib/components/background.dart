import 'package:flutter/material.dart';

Container kBasicBackground = Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: const AssetImage('images/background/ball_3.png'),
      colorFilter: ColorFilter.mode(
        Colors.white.withOpacity(0.1),
        BlendMode.modulate,
      ),
    ),
  ),
);
