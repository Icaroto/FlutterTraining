import 'package:flutter/material.dart';

class FiltersSideScreen extends StatelessWidget {
  const FiltersSideScreen({
    required this.filters,
    required this.onClose,
    Key? key,
  }) : super(key: key);

  final List<Widget> filters;
  final Function() onClose;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 80,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Filters'),
            ),
          ),
          Column(
            children: [...filters],
          ),
          const Divider(thickness: 2),
          Center(
            child: TextButton(
              onPressed: onClose,
              child: const Text("Close"),
            ),
          ),
        ],
      ),
    );
  }
}
