import 'package:flutter/material.dart';

class Game2048 extends StatelessWidget {
  const Game2048({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2048 Game')),
      body: Center(child: const Text('2048 Game')),
    );
  }
}
