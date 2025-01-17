import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribby3/resources/game_play_state.dart';
import 'package:scribby3/screens/game_screen/game_screen.dart';
import 'package:scribby3/screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GamePlayState()),
      ],
      child: MaterialApp(
        home: const HomeScreen(),
      ),
    );
  }
}

