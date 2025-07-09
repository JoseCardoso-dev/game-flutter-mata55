import 'package:flutter/material.dart';
import 'presentation/screens/game_screen.dart';

void main() {
  runApp(SimonMusicalApp());
}

class SimonMusicalApp extends StatelessWidget {
  const SimonMusicalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simon Musical',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: GameScreen(),
    );
  }
}
