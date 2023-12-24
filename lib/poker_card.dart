import 'package:flutter/material.dart';
import 'dart:math';

class PokerCard extends StatefulWidget {
  const PokerCard({
    super.key,
  });

  @override
  State<PokerCard> createState() => _PokerCardState();
}

class _PokerCardState extends State<PokerCard> {
  static double angle = 0;
  bool isBoth = false;
  bool isVertical = false;
  bool isBack = true;

  getMatrix(double val) => isBoth
      ? (Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(val)
        ..rotateX(val))
      : isVertical
          ? (Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(val))
          : (Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(val));

  flipHorizontally() {
    setState(() {
      isBoth = false;
      isVertical = false;
      angle = (angle + pi) % (2 * pi);
    });
  }

  flipVertically() {
    setState(() {
      isBoth = false;
      isVertical = true;
      angle = (angle + pi) % (2 * pi);
    });
  }

  flipBoth() {
    setState(() {
      isBoth = true;
      isVertical = true;
      angle = (angle + pi) % (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: GestureDetector(
              onTap: flipBoth,
              child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: angle),
                  duration: const Duration(seconds: 1),
                  builder: (BuildContext context, double val, __) {
                    return (Transform(
                        alignment: Alignment.center,
                        transform: getMatrix(val),
                        child: SizedBox(
                            width: 70,
                            height: 70,
                            child: val < pi / 2
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: const DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage("assets/back.png"),
                                      ),
                                    ),
                                  )
                                : Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()..rotateY(pi),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: const DecorationImage(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                    "assets/face.png"))))))));
                  }),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: flipHorizontally,
                child: const Text('Flip horizontally')),
            ElevatedButton(
                onPressed: flipVertically,
                child: const Text('Flip Vertically')),
          ],
        )
      ],
    );
  }
}
