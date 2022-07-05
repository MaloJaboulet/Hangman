import 'package:flutter/material.dart';


class Words extends ChangeNotifier {
  late List<String> words;

  Words({required this.words});

  Words.fromJson(Map<String, dynamic> json) {
    words = json['words'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['words'] = this.words;
    return data;
  }
}
