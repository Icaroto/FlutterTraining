import 'package:flutter/material.dart';

class SwitchOption extends StatelessWidget {
  const SwitchOption({
    required this.title,
    required this.switchValue,
    required this.onSwitch,
    super.key,
  });

  final String title;
  final bool switchValue;
  final Function(bool) onSwitch;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.blue,
      borderOnForeground: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title),
          ),
          Switch(
            value: switchValue,
            activeColor: Colors.red,
            onChanged: (bool value) => {onSwitch(value)},
          )
        ],
      ),
    );
  }
}
