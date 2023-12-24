import 'package:flutter/material.dart';
import 'package:flutter_card_flip_demo/poker_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Card Flip"),
        centerTitle: true,
        elevation: 4,
      ),
      body: const Center(child: PokerCard()),
    );
  }
}
