import 'dart:math';

import 'package:flutter/material.dart';


class Words extends ChangeNotifier {
  late List<String> _wordsList = ["Haus"];

  Words({required List<String> wordList}){
     this._wordsList = wordList;
  }

  Words.fromJson(Map<String, dynamic> json) {
    _wordsList = json['words'].cast<String>();
  }



  List<String> get getWordList => _wordsList;

  String get getWord {
    if (_wordsList.isNotEmpty) {
       return _wordsList.elementAt(Random().nextInt(_wordsList.length));
    }
    return "Empty";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['words'] = this._wordsList;
    return data;
  }
}
