import 'package:flutter/material.dart';


class Words extends ChangeNotifier {
  late List<String> wordsList;

  Words({required this.wordsList});

  Words.fromJson(Map<String, dynamic> json) {
    wordsList = json['words'].cast<String>();
  }

  add(String word){
    wordsList.add(word);
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['words'] = this.wordsList;
    return data;
  }
}
