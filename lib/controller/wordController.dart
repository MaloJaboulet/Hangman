import 'package:flutter/cupertino.dart';
import 'package:hangman/model/words.dart';

class WordController extends ChangeNotifier{
  String _word = "";
  bool _wordGuessed = true;
  bool _blankSpaces = true;
  late Words _words;
  late List<String> _lettersGuessed = [];

  WordController(String word, bool wordGuessed, Words words){
    _wordGuessed = wordGuessed;
    _words = words;
    _word = _words.getWord.toUpperCase();
    for (var i=0;i<_word.length; i++){
      _lettersGuessed.add("");
    }
  }


  WordController.name(Words words){
    _words = words;
    _word = _words.getWord;
    for (var i=0;i<7; i++){
      _lettersGuessed.add("");
    }
  }

  bool phoneShaked(){
    if (blankSpaces == 0){
      _word = _words.getWord;
      return true;
    }else{
      return false;
    }
  }

  add(String word){
    _words.getWordList.add(word);
    notifyListeners();
  }

  guessLetter(String letter){
    if (_word.contains(letter)){
      List<int> indexList = [];
      List<String> temp = _word.split("");

      for (var i=0; i<temp.length; i++){
        if(temp.elementAt(i) == letter){
          indexList.add(i);
        }
      }
      for (var index in indexList){
        _lettersGuessed.removeAt(index);
        _lettersGuessed.insert(index, letter);
      }
    }
    notifyListeners();
    print(_lettersGuessed);
    if (!_lettersGuessed.contains("")){
      _blankSpaces = false;
    }
  }


  List<String> splitWord(){
    //_lettersGuessed = getWord.toUpperCase().trim().split("");
    print(_lettersGuessed);
    return _lettersGuessed;
  }

  String get getWord =>
      _words.getWord;


  bool get blankSpaces => _blankSpaces;


  set blankSpaces(bool value) {
    _blankSpaces = value;
  }

  Words get getWords => _words;

  set words(Words value) {
    _words = value;
  }

  bool get wordGuessed => _wordGuessed;

  set wordGuessed(bool value) {
    _wordGuessed = value;
  }

  String get word => _word;

  set word(String value) {
    _word = value;
  }

   setWord(){
    _word = _words.getWord.toUpperCase();
    _lettersGuessed.clear();
    if (_words.getWordList.isNotEmpty) {
      for (var i = 0; i < _word.length; i++) {
        _lettersGuessed.add("");
      }
    }else{
      for (var i = 0; i < 7; i++) {
        _lettersGuessed.add("");
      }
    }
    _blankSpaces = true;
    print(_word);
  }
}