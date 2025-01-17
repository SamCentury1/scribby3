import 'package:flutter/material.dart';

class GamePlayState extends ChangeNotifier {

  late List<Map<String,dynamic>> _tileData = [
    // {"key": 0, "row": 1, "column": 1, "body": "", "active": false},
    // {"key": 1, "row": 1, "column": 2, "body": "", "active": false},
    // {"key": 2, "row": 1, "column": 3, "body": "", "active": false},
    // {"key": 3, "row": 1, "column": 4, "body": "", "active": false},
    // {"key": 4, "row": 2, "column": 1, "body": "", "active": false},
    // {"key": 5, "row": 2, "column": 2, "body": "", "active": false},
    // {"key": 6, "row": 2, "column": 3, "body": "", "active": false},
    // {"key": 7, "row": 2, "column": 4, "body": "", "active": false},
    // {"key": 8, "row": 3, "column": 1, "body": "", "active": false},
    // {"key": 9, "row": 3, "column": 2, "body": "", "active": false},
    // {"key": 10, "row": 3, "column": 3, "body": "", "active": false},
    // {"key": 11, "row": 3, "column": 4, "body": "", "active": false},
    // {"key": 12, "row": 4, "column": 1, "body": "", "active": false},
    // {"key": 13, "row": 4, "column": 2, "body": "", "active": false},
    // {"key": 14, "row": 4, "column": 3, "body": "", "active": false},
    // {"key": 15, "row": 4, "column": 4, "body": "", "active": false},

  ];
  List<Map<String,dynamic>> get tileData => _tileData;
  void setTileData(List<Map<String,dynamic>> value) {
    _tileData = value;
    notifyListeners();
  }

  late Map<String,dynamic> _elementSizes = {};
  Map<String,dynamic> get elementSizes => _elementSizes;
  void setElementSizes(Map<String,dynamic> value) {
    _elementSizes = value;
    notifyListeners();
  }
  late double _tileSize = 0.0;
  double get tileSize => _tileSize;
  void setTileSize(double value) {
    _tileSize = value;
    notifyListeners();
  }
}