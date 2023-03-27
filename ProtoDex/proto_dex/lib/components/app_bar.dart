import 'package:flutter/material.dart';

class AppBarBase extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  const AppBarBase({
    required this.title,
    required this.actions,
    Key? key,
  }) : super(key: key);

  final Widget title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: true,
        actions: actions,
        centerTitle: true,
        title: title);
  }
}
