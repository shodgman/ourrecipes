import 'package:flutter/material.dart';
import '../utils/colourUtils.dart';

Image logoImage(String imageName) {
  return Image.asset(
    imageName,
    height: 200,
    width: 200,
    fit: BoxFit.fitWidth,
  );
}

BoxDecoration backgroundDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        hexStringToColour("CB2B93"),
        hexStringToColour("9546C4"),
        hexStringToColour("5E61F4"),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
}
