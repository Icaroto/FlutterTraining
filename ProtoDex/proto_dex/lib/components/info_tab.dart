import 'package:flutter/material.dart';

class PokeInfoCard extends StatelessWidget {
  const PokeInfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(),
        ),
        const SizedBox(height: 100),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 1.5,
                  spreadRadius: 1.5,
                  offset: Offset(2, 0),
                  blurStyle: BlurStyle.inner,
                ),
              ],
              color: Color.fromARGB(255, 48, 57, 67),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
                bottom: Radius.circular(0),
              ),
            ),
            child: DefaultTabController(
              length: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const TabBar(tabs: [
                    Tab(text: "Catch"),
                    Tab(text: "Attributes"),
                    Tab(text: "Useful"),
                  ]),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const TabBarView(children: [
                        Text("Home Body"),
                        Text("Articles Body"),
                        Text("User Body"),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PokeButton extends StatelessWidget {
  PokeButton({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      //Shadow
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 0.5,
              spreadRadius: 0.5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        //Button
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black, //color of border
                width: 1, //width of border
              ),
              color: Colors.white),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
