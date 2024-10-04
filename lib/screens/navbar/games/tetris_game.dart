import 'package:flutter/material.dart';

class TetrisGame extends StatelessWidget {
  const TetrisGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tetris Game')),
      body: Center(child: const Text('Tetris Game')),
    );
  }
}
