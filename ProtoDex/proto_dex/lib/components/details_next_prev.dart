import 'package:flutter/material.dart';

class NextPrevButtons extends StatelessWidget {
  const NextPrevButtons({
    super.key,
    required this.onLeftClick,
    required this.onRightClick,
  });

  final Function()? onLeftClick;
  final Function()? onRightClick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onLeftClick,
              child: (onLeftClick == null)
                  ? Container()
                  : icon(Icons.keyboard_arrow_left),
            ),
            GestureDetector(
              onTap: onRightClick,
              child: (onRightClick == null)
                  ? Container()
                  : icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
    );
  }

  Icon icon(icon) {
    return Icon(
      icon,
      size: 30,
      color: Colors.black,
    );
  }
}
