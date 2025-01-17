
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scribby3/resources/game_play_state.dart';

class Helpers {

  double getTileSize(Size playAreaSize, int numRows, int numCols) {
    late double res = 0.0;
    final double minTileSize = 50;
    final double maxTileSize = 80;

    late int maxAxisCount = max(numRows,numCols);
    late double optimalSize = double.parse( ((playAreaSize.width*0.95)/maxAxisCount) .toStringAsFixed(2));
  
    if (optimalSize < minTileSize) {
      res = minTileSize;
    } else if (optimalSize > maxTileSize) {
      res = maxTileSize;
    } else {
      res = optimalSize;
    }
    return res;
  }

  List<int> getNumAxis(List<Map<String,dynamic>> tileObjects) {
    List<int> rows = [];
    List<int> cols = [];
  
    for (int i=0; i< tileObjects.length; i++) {
      int row = tileObjects[i]["row"];
      int col = tileObjects[i]["column"];
      rows.add(row);
      cols.add(col);
    }
  
    int maxRow = rows.reduce(max);
    int maxCols = cols.reduce(max);
    List<int> res = [maxRow,maxCols];
    return res;
  }



  int? getTileTapped(Offset locationTapped,Size canvasSize, List<Map<String,dynamic>> tileObjects) {
  
    int? targetTileIndex = null;
    double locationX = locationTapped.dx;
    double locationY = locationTapped.dy;

    int numRows = getNumAxis(tileObjects)[0];
    int numCols = getNumAxis(tileObjects)[1];
    final double tileSize = getTileSize(canvasSize,numRows,numCols);
    final double widthGap = (canvasSize.width - (numRows*tileSize))/2;
    final double heightGap = (canvasSize.height-canvasSize.width);//(canvasSize.height - (numCols*tileSize))/2;
    for (int i=0; i<tileObjects.length; i++) {
      Map<String,dynamic> tileObject = tileObjects[i];
      final double left = widthGap + (tileSize * (tileObject["row"]-1));
      final double top = heightGap + (tileSize * (tileObject["column"]-1));
      final double right = left+tileSize;
      final double bottom = top+tileSize;
    
      if (locationX > left && locationX < right && locationY < bottom && locationY > top) {
        targetTileIndex = tileObjects[i]["key"];
      }
    }
  
    if (targetTileIndex != null) {
  //     print("the tapped tile object is ${tileObjects[targetTileIndex]}");
    } else {
      print("out of bounds");
    }
  
    return targetTileIndex;
  //   return targetTileIndex;
  
  }

  void updateTileObjectsToAddCenterOffset(Size size, GamePlayState gamePlayState) {

    for (int i=0; i<gamePlayState.tileData.length; i++) {
      Map<String,dynamic> tileObject = gamePlayState.tileData[i];
      int numRows = getNumAxis(gamePlayState.tileData)[0];
      int numCols = getNumAxis(gamePlayState.tileData)[1];


    }
  }



  List<Map<String,dynamic>> createTileObjects(int numRows, int numCols) {
    List<Map<String,dynamic>> objects = [];
    for (int c=0; c<numCols; c++) {
      for (int r=0; r<numRows; r++) {
        int tileId = objects.length;
        late Map<String,dynamic> tileObject = {
          "key": tileId,
          "row": r+1,
          "column" : c+1,
          "body": "",
          "active": false,
        };
        objects.add(tileObject);
      }
    }
    return objects;
  }

  TextPainter displayText(Canvas canvas, Size size, String body, Offset location) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 28,
    );
    TextSpan textSpan = TextSpan(
      text: body,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final position = Offset(location.dx - (textPainter.width/2), location.dy - (textPainter.height/2));
    textPainter.paint(canvas, position);
    return textPainter;   
  }

  Size getPlayAreaSize(Size screenSize) {
    final double maxScreenWidth = 360.0;
    final double maxScreenHeight = 750.0;

    late double playAreaWidth = screenSize.width;
    late double playAreaHeight = screenSize.height;

    if (screenSize.width > maxScreenWidth) {
      playAreaWidth = maxScreenWidth;
    }

    if (screenSize.height > maxScreenHeight) {
      playAreaHeight = maxScreenHeight;
    } 

    return Size(playAreaWidth,playAreaHeight);
  }

  void getElementSizes(GamePlayState gamePlayState, Size size) {
    Size playAreaSize = getPlayAreaSize(size);
    int numRows = getNumberAxis(gamePlayState,'row');
    int numCols = getNumberAxis(gamePlayState,'column');
    double tileSize = getTileSize(playAreaSize, numRows, numCols);

    final double boardWidth = numCols*tileSize;
    final double boardHeight = numRows*tileSize;

    final double scoreboardSection = 0.1;
    final Size boardSize = Size(boardWidth,boardHeight);
    final double randomLetterSection =  double.parse(( ((tileSize*2)/playAreaSize.height)).toStringAsFixed(4)) ;
    final double bonusShare =  double.parse(( (tileSize*0.6)/playAreaSize.height).toStringAsFixed(4)) ;
    final double boardSection = double.parse(((boardSize.height/playAreaSize.height)).toStringAsFixed(4)) ;
    final double reserveLetterSection = double.parse(((tileSize*1.5)/playAreaSize.height).toStringAsFixed(4));
    final double gameElementsShare = (scoreboardSection+bonusShare+randomLetterSection+boardSection+reserveLetterSection);
    final double gapSection = double.parse((1.0 - gameElementsShare).toStringAsFixed(4)) ;

    final double minimumHeight = gameElementsShare*playAreaSize.height;
    final double minimumAspectRatio = minimumHeight/playAreaSize.width;
    final double currentAspectRatio = (playAreaSize.height/playAreaSize.width);
    final double scaleFactor = currentAspectRatio/minimumAspectRatio;

    late double playAreaHeight = playAreaSize.height;
    late double playAreaWidth = playAreaSize.width;

    if (gapSection <=0.0) {
      playAreaHeight=playAreaSize.height*scaleFactor;
      playAreaWidth=playAreaSize.width*scaleFactor;
      playAreaSize = Size(playAreaWidth,playAreaWidth);
      tileSize = getTileSize(playAreaSize, numRows, numCols);
      gapSection == 0.0;
    }

    Map<String,dynamic> sizeData = {
      "screenSize": size,
      "playArea": playAreaSize,
      "scoreboard": Size(playAreaWidth,scoreboardSection*playAreaHeight),
      "gapSpace":  Size(playAreaWidth,gapSection*playAreaHeight),
      "randomLetters": Size(playAreaWidth,randomLetterSection*playAreaHeight),
      "board": Size(playAreaWidth,boardSection*playAreaHeight),
      "reserveLetters": Size(playAreaWidth,reserveLetterSection*playAreaHeight),
      "tileSize":Size(tileSize,tileSize),
      "bonus": Size(playAreaWidth,bonusShare*playAreaHeight)
    };

    gamePlayState.setElementSizes(sizeData);
  }

  int getNumberAxis(GamePlayState gamePlayState, String axis) {
    List<int> values = [];
    for (int i=0; i<gamePlayState.tileData.length; i++) {
      if (!values.contains(gamePlayState.tileData[i][axis])) {
        values.add(gamePlayState.tileData[i][axis]);
      }
    }
    return values.length;
  }
}
