import 'package:flutter/cupertino.dart';
import 'package:hangman/model/player.dart';
import 'package:hangman/model/words.dart';
import 'package:vibration/vibration.dart';

class WordController extends ChangeNotifier {
  String _word = "";
  bool _wordGuessed = true;
  bool _blankSpaces = true;
  late Words _words;
  late List<String> _lettersGuessed = [];
  int _guessesDone = 0;
  bool _allowedVibration = false;

  WordController(String word, bool wordGuessed, Words words) {
    _wordGuessed = wordGuessed;
    _words = words;
    _word = _words.getWord.toUpperCase();
    for (var i = 0; i < _word.length; i++) {
      _lettersGuessed.add("");
    }
    setAllowedVibration();
  }

  WordController.name(Words words) {
    _words = words;
    _word = _words.getWord;
    for (var i = 0; i < 7; i++) {
      _lettersGuessed.add("");
    }
    setAllowedVibration();
  }

  bool phoneShaked(Player player) {
    if (!blankSpaces) {
      restartWord();
      player.increaseHighScore(player.highScore + 1);
      return true;
    } else {
      return false;
    }
  }

  add(String word) {
    _words.getWordList.add(word);
    notifyListeners();
  }

  guessLetter(String letter) {
    if (_word == "Empty") {
      setWord();
    } else {
      if (_word.contains(letter)) {
        List<int> indexList = [];
        List<String> temp = _word.split("");

        for (var i = 0; i < temp.length; i++) {
          if (temp.elementAt(i) == letter) {
            indexList.add(i);
          }
        }
        for (var index in indexList) {
          _lettersGuessed.removeAt(index);
          _lettersGuessed.insert(index, letter);
        }
      } else {
        addGuessesLeft();
        print(allowedVibration);

        Vibration.vibrate(duration: 100,amplitude: 255);
      }

      print(_word);
      print(_lettersGuessed);
      if (!_lettersGuessed.contains("")) {
        _blankSpaces = false;
      }
      notifyListeners();
    }
  }

  restartWord() {
    _lettersGuessed.clear();
    _word = "";
    _word = _words.getWord.toUpperCase();
    _blankSpaces = true;
    for (var i = 0; i < _word.length; i++) {
      _lettersGuessed.add("");
    }
    _guessesDone = 0;
    notifyListeners();
  }

  setWord() {
    _lettersGuessed.clear();
    if (_words.getWordList.isNotEmpty) {
      _word = _words.getWord.toUpperCase();
      for (var i = 0; i < _word.length; i++) {
        _lettersGuessed.add("");
      }
    } else {
      for (var i = 0; i < 7; i++) {
        _lettersGuessed.add("");
      }
    }

    _blankSpaces = true;
  }

  revealWord() {
    _lettersGuessed = _word.split("");
    _blankSpaces = false;
    notifyListeners();
  }

  addGuessesLeft() {
    if (_guessesDone < 10) {
      _guessesDone = _guessesDone + 1;
      if (_guessesDone == 10) {
        revealWord();
      }
    }
  }

  List<String> splitWord() {
    return _lettersGuessed;
  }

  String get getWord => _words.getWord;

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

  List<String> get lettersGuessed => _lettersGuessed;

  set lettersGuessed(List<String> value) {
    _lettersGuessed = value;
  }

  int get getGuessesLeft => _guessesDone;

  set guessesLeft(int value) {
    _guessesDone = value;
  }

  String getImagePath() {
    return 'assets/images/hangman${getGuessesLeft}.png';
  }

  int get guessesDone => _guessesDone;

  set guessesDone(int value) {
    _guessesDone = value;
  }

  bool get allowedVibration => _allowedVibration;

  set allowedVibration(bool value) {
    _allowedVibration = value;
  }

  setAllowedVibration() async {
    //_allowedVibration = await Vibrate.canVibrate;
  }
}
