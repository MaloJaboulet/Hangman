import 'dart:convert';

import 'package:hangman/model/words.dart';
import 'package:http/http.dart' as http;

class ListOfWords{
  Future<Words> fetchWords() async {
    final response = await http
        .get(Uri.parse('https://zufallsworte.herokuapp.com/substantiv_anzahl/7/30'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Words wordList = Words.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      for(var word in wordList.wordsList){
          if (word.contains("ß")){
            word = word.replaceAll("ß", "ss");
          }
        }
      return wordList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}