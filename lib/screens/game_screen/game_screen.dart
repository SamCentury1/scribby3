import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribby3/functions/helpers.dart';
import 'package:scribby3/resources/game_play_state.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<GamePlayState>(
        builder: (context,gamePlayState,child) {

          print("tile state = ${gamePlayState.tileData}");
          return Scaffold(
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Listener(
                onPointerUp: (var details) {
                  print("tapped down at location: ${details.localPosition}");
                },
                onPointerMove: (var details) {
                  print("moved at location: ${details.localPosition}");
                },
                onPointerDown: (var details) {
                  print("tapped up at location: ${details.localPosition}");
                },
                child: CustomPaint(
                  painter: MainCanvasPainter(gamePlayState: gamePlayState)
                ),
              )
            )
          );
        }
      ),
    );    
  }
}

class MainCanvasPainter extends CustomPainter {
  final GamePlayState gamePlayState; 
  MainCanvasPainter({
    required this.gamePlayState
  });
   
  @override  
  void paint(Canvas canvas, Size size) {
   
    // shortcut for getting width and heigth
    final double w = size.width;
    final double h = size.height;

    // final double tileSize = 50.0;

    late Offset canvasCenter = Offset(w/2, h/2);
    int numRows = Helpers().getNumberAxis(gamePlayState, 'row');
    int numCols = Helpers().getNumberAxis(gamePlayState, 'column');

    Paint backgroundPaint = Paint()
    ..color = Color.fromARGB(245,31,44,145);
    // Rect canvasRect = Rect.fromCenter(center: canvasCenter,w,h);
    // canvas.drawRect(canvasRect, backgroundPaint);
    canvas.drawPaint(backgroundPaint);

    drawPlayArea(canvas,gamePlayState,canvasCenter);

    drawGamePlayElements(canvas,size,gamePlayState);

    drawBoardTiles(canvas,size,gamePlayState,);
    // Size playAreaSize = gamePlayState.elementSizes["playArea"];
    // Paint playAreaPaint = Paint()
    // ..color = Color.fromARGB(245, 0, 0, 0);
    // Rect playAreaRect = Rect.fromCenter(center: canvasCenter ,width: playAreaSize.width,height: playAreaSize.height);
    // canvas.drawRect(playAreaRect, playAreaPaint);
   

    // for (int i=0; i<gamePlayState.tileData.length; i++) {

    //   Map<String,dynamic> tileObject = gamePlayState.tileData[i];

    //   // Rect tileRect = RRect.fro

    // }
   
  }
  @override
  bool shouldRepaint(MainCanvasPainter oldDelegate) => true;
  // @override
  // bool shouldRebuildSemantics(MainCanvasPainter oldDelegate) => false;  
}


Canvas drawPlayArea(Canvas canvas, GamePlayState gamePlayState, Offset center) {
    Size playAreaSize = gamePlayState.elementSizes["playArea"];
    Paint playAreaPaint = Paint()
    ..color = Color.fromARGB(245, 0, 0, 0);
    Rect playAreaRect = Rect.fromCenter(center: center, width: playAreaSize.width, height: playAreaSize.height);
    canvas.drawRect(playAreaRect, playAreaPaint);
    return canvas;
}


Canvas drawGamePlayElements(Canvas canvas, Size size, GamePlayState gamePlayState) {

  final Size scoreboardSize = gamePlayState.elementSizes["scoreboard"];
  final Size screenSizeSize = gamePlayState.elementSizes["screenSize"];
  final Size playAreaSize = gamePlayState.elementSizes["playArea"];
  final Size gapSpaceSize = gamePlayState.elementSizes["gapSpace"];
  final Size randomLettersSize = gamePlayState.elementSizes["randomLetters"];
  final Size boardSize = gamePlayState.elementSizes["board"];
  final Size reserveLettersSize = gamePlayState.elementSizes["reserveLetters"];
  final Size tileSize = gamePlayState.elementSizes["tileSize"];
  final Size bonusSize = gamePlayState.elementSizes["bonus"];

  late double playAreaHorizontalGap = (size.width-playAreaSize.width)/2;
  late double playAreaVerticalGap = (size.height-playAreaSize.height)/2;

  late double centerX = size.width/2;


  // -------- scoreboard ----------------------
  Paint scoreboardPaint = Paint()
  ..color = Colors.brown;

  Offset scoreboardCenter = Offset(centerX, (playAreaVerticalGap+ (scoreboardSize.height/2)));
  Rect scoreboardRect = Rect.fromCenter(center: scoreboardCenter, width: scoreboardSize.width, height: scoreboardSize.height);
  canvas.drawRect(scoreboardRect, scoreboardPaint);
  // ----------------------------------------------

  // -------- gap 1 ----------------------
  Paint gap1Paint = Paint()
  ..color = const Color.fromARGB(255, 245, 188, 33);
  playAreaVerticalGap = playAreaVerticalGap + scoreboardSize.height;
  Offset gapCenter1 = Offset(centerX,(playAreaVerticalGap+((gapSpaceSize.height/3)/2)));
  Rect gap1Rect = Rect.fromCenter(center: gapCenter1, width: gapSpaceSize.width, height: gapSpaceSize.height/3);
  canvas.drawRect(gap1Rect, gap1Paint);
  // ----------------------------------------------

  // -------- bonus ----------------------
  Paint bonusSectionPaint = Paint()
  ..color = const Color.fromARGB(255, 124, 235, 50);
  playAreaVerticalGap = playAreaVerticalGap + (gapSpaceSize.height/3);
  Offset bonusCenter = Offset(centerX,(playAreaVerticalGap+(bonusSize.height/2)));
  Rect bonusRect = Rect.fromCenter(center: bonusCenter, width: bonusSize.width, height: bonusSize.height);
  canvas.drawRect(bonusRect, bonusSectionPaint);
  // ----------------------------------------------
  
  // -------- gap 2 ----------------------
  Paint gap2Paint = Paint()
  ..color = const Color.fromARGB(255, 203, 62, 231); 
  playAreaVerticalGap = playAreaVerticalGap + bonusSize.height;
  Offset gapCenter2 = Offset(centerX,(playAreaVerticalGap+((gapSpaceSize.height/3)/2)));
  Rect gap2Rect = Rect.fromCenter(center: gapCenter2, width: gapSpaceSize.width, height: gapSpaceSize.height/3);
  canvas.drawRect(gap2Rect, gap2Paint);
  // ----------------------------------------------
  
  // -------- random letters ----------------------
  Paint randomLettersSectionPaint = Paint()
  ..color = const Color.fromARGB(255, 55, 190, 224);
  playAreaVerticalGap = playAreaVerticalGap + (gapSpaceSize.height/3);
  Offset randomLettersSectionCenter = Offset(centerX,(playAreaVerticalGap+(randomLettersSize.height/2)));
  Rect randomLetterSectionRect = Rect.fromCenter(center: randomLettersSectionCenter, width: randomLettersSize.width, height: randomLettersSize.height);
  canvas.drawRect(randomLetterSectionRect, randomLettersSectionPaint);
  // ----------------------------------------------

  // -------- board ----------------------
  Paint boardPaint = Paint()
  ..color = const Color.fromARGB(255, 1, 45, 75);  
  playAreaVerticalGap = playAreaVerticalGap + randomLettersSize.height;
  Offset boardCenter = Offset(centerX, playAreaVerticalGap+ (boardSize.height/2));
  Rect boardRect = Rect.fromCenter(center: boardCenter, width: boardSize.width, height: boardSize.height);
  canvas.drawRect(boardRect, boardPaint);

  // ----------------------------------------------


  // -------- reserves ----------------------
  Paint reservesSectionPaint = Paint()
  ..color = const Color.fromARGB(255, 184, 15, 15);
  playAreaVerticalGap = playAreaVerticalGap + boardSize.height;
  Offset reserveLettersCenter = Offset(centerX, playAreaVerticalGap+ (reserveLettersSize.height/2));
  Rect reserveLettersRect = Rect.fromCenter(center: reserveLettersCenter, width: reserveLettersSize.width, height: reserveLettersSize.height);
  canvas.drawRect(reserveLettersRect, reservesSectionPaint);
  // ----------------------------------------------

  // -------- gap 3 ----------------------
  Paint gap3Paint = Paint()
  ..color = const Color.fromARGB(255, 69, 13, 158);
  playAreaVerticalGap = playAreaVerticalGap + reserveLettersSize.height;
  Offset gapCenter3 = Offset(centerX,(playAreaVerticalGap+((gapSpaceSize.height/3)/2)));
  Rect gap3Rect = Rect.fromCenter(center: gapCenter3, width: gapSpaceSize.width, height: gapSpaceSize.height/3);
  canvas.drawRect(gap3Rect, gap3Paint);
  // ----------------------------------------------



  return canvas;

}

Canvas drawBoardTiles(Canvas canvas, Size size,  GamePlayState gamePlayState) {


  final Size scoreboardSize = gamePlayState.elementSizes["scoreboard"];
  final Size playAreaSize = gamePlayState.elementSizes["playArea"];
  final Size gapSpaceSize = gamePlayState.elementSizes["gapSpace"];
  final Size randomLettersSize = gamePlayState.elementSizes["randomLetters"];
  final Size tileSize = gamePlayState.elementSizes["tileSize"];
  final Size bonusSize = gamePlayState.elementSizes["bonus"];

  int numRows = Helpers().getNumAxis(gamePlayState.tileData)[0];
  int numCols = Helpers().getNumAxis(gamePlayState.tileData)[1];

  late double playAreaHorizontalGap = (size.width-playAreaSize.width)/2;
  late double boardHorizontalGap = (playAreaSize.width-(tileSize.width*numCols))/2;


  Paint containerPaint = Paint()
  ..color = Colors.white;

  Paint tilePaint = Paint()
  ..color = Colors.lightBlueAccent;

  for (int i=0; i<gamePlayState.tileData.length; i++) {
    Map<String,dynamic> tileObject = gamePlayState.tileData[i];
    final int row = tileObject['row'];
    final int column = tileObject['column'];

    final double leftGap = (playAreaHorizontalGap+boardHorizontalGap+(tileSize.width/2));
    final double left = leftGap+(tileSize.width*(column-1));

    final double topGap = ((size.height-playAreaSize.height)/2)
    + (2*(gapSpaceSize.height/3))
    + scoreboardSize.height
    + bonusSize.height
    + randomLettersSize.height
    + (tileSize.height/2);

    final double top = topGap + (tileSize.height*(row-1));

    final Offset tileCenter = Offset(left,top);

    final Rect tileContainer = Rect.fromCenter(center: tileCenter, width: tileSize.width, height: tileSize.height);
    final Rect tileRect = Rect.fromCenter(center: tileCenter, width: tileSize.width*0.9, height: tileSize.height*0.9);
    final RRect tileRRect = RRect.fromRectAndRadius(tileRect, Radius.circular(12.0));

    canvas.drawRect(tileContainer, containerPaint);
    canvas.drawRRect(tileRRect, tilePaint);

    // Helpers().displayText(canvas, size, tileObject[i]["body"], tileCenter);
  }

  return canvas;
}

