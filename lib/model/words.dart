import 'dart:math';

import 'package:flutter/material.dart';


class Words extends ChangeNotifier {
  late List<String> _wordsList = [];

  Words({required List<String> wordList}){
     this._wordsList = wordList;
  }

  Words.fromJson(Map<String, dynamic> json) {
    _wordsList = json['words'].cast<String>();
  }

  add(String word){
    _wordsList.add(word);
    notifyListeners();
  }

  List<String> get getWordList => List.unmodifiable(_wordsList);

  String get getWord =>
      _wordsList.elementAt(Random().nextInt(_wordsList.length));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['words'] = this._wordsList;
    return data;
  }
}
