import 'dart:ui';

import 'item.dart';

class Group {
  Group({required this.name, required this.items});

  final String name;
  final List<Item> items;
  Color? color;
  // String? image;
}
