import 'package:flutter/material.dart';

class NavItem {
  final Image image; // Mengubah parameter icon menjadi image
  final Image secondImage;
  final Text title;
  final List<Color> color;

  NavItem(
    this.image,
    this.secondImage,
    this.title,
    this.color,
  );
}
