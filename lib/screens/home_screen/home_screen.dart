import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribby3/functions/helpers.dart';
import 'package:scribby3/resources/game_play_state.dart';
import 'package:scribby3/screens/game_screen/game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Map<String,dynamic>> levelData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    levelData = [
      {"rows": 5, "columns": 5},
      {"rows": 6, "columns": 5},
      {"rows": 7, "columns": 5},
      {"rows": 8, "columns": 5},
      {"rows": 5, "columns": 6},
      {"rows": 6, "columns": 6},
      {"rows": 7, "columns": 6},
      {"rows": 8, "columns": 6},
      {"rows": 5, "columns": 7},
      {"rows": 6, "columns": 7},
      {"rows": 7, "columns": 7},
      {"rows": 8, "columns": 7},
      {"rows": 5, "columns": 8},
      {"rows": 6, "columns": 8},
      {"rows": 7, "columns": 8},
      {"rows": 8, "columns": 8},
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GamePlayState>(
        builder: (context,gamePlayState,child) {
          return Center(
            child: Column(
              children: displayLevels(context, gamePlayState, levelData),
            )
          );
        }
      ),
    );
  }
}

List<Widget> displayLevels(BuildContext context, GamePlayState gamePlayState, List<Map<String,dynamic>> levelData) {

  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;



  List<Widget> res = [];
  for (int i=0; i<levelData.length;i++) {
    final int rows = levelData[i]["rows"];
    final int columns = levelData[i]["columns"];
    String body = "$columns by $rows";
    Widget widget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        // height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 56, 56, 56)
        ),
        child: GestureDetector(
          onTap: () {

            List<Map<String,dynamic>> tileObjects = Helpers().createTileObjects(rows, columns);
            gamePlayState.setTileData(tileObjects);


            Helpers().getElementSizes(gamePlayState,MediaQuery.of(context).size);
            // final double tileSize = Helpers().getTileSize(MediaQuery.of(context).size, rows,columns);
            // gamePlayState.setTileSize(tileSize);


            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const GameScreen())
            );  
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                body,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    res.add(widget);
  }
  return res;
}