import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hangman/controller/wordController.dart';
import 'package:hangman/model/player.dart';
import 'package:hangman/pages/listPage.dart';
import 'package:hangman/pages/startPage.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';

class Homepage extends StatefulWidget {
  late WordController wordController;
  late Player player;

  Homepage(WordController wordController, Player player) {
    print(player.name);
    this.wordController = wordController;
    this.player = player;
    wordController.setWord();
  }

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //state vars
  Timer? timer;
  Duration _duration = Duration(seconds: 25);

  forceRedraw() {
    setState(() => {});
  }

  @override
  void initState() {
    super.initState();

    widget.wordController.restartWord();
    startTimer();


    ShakeDetector.autoStart(
      onPhoneShake: () {
        if (widget.wordController.phoneShaked()) {
          forceRedraw();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<WordController>(context);


    if(widget.wordController.getTimeDone) {
      widget.wordController.resetTime();
      stopTimer();
      startTimer();
    }



    String strDigits(int n) => n.toString().padLeft(2, '0');
    if (strDigits(_duration.inSeconds) == "00") {
      widget.wordController.timeDone();
      stopTimer();
    }



    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return StartPage(widget.wordController);
                },
              ),
            );
          },
        ),
        title: const Center(child: Text("Hangman")),
        actions: [
          IconButton(
              icon: Icon(Icons.view_headline_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ListPage(widget.wordController);
                    },
                  ),
                );
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height / 2) - 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.wordController.getImagePath()),
                    fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height / 2) - 50,
              child: Container(
                child: Column(
                  children: [
                    solution(controller),
                    keyBoard(),
                    Padding(
                      padding:
                      EdgeInsets.only(left:20, bottom: 0, right: 20, top:10),
                      child: Text(widget.wordController.getTimeDone
                          ? "The game is done. Please restart the game through the start page."
                          : strDigits(_duration.inSeconds)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget solution(WordController controller) {
    return Row(
      children: createPlacesLetters(controller),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  List<Widget> createPlacesLetters(WordController controller) {
    List<Widget> list = [];
    List<String> listLetters = widget.wordController.splitWord();
    for (var i = 0; i < listLetters.length; i++) {
      list.add(
        Container(
          child: Center(
            child: Text(
              listLetters.elementAt(i),
              style: TextStyle(fontSize: 30),
            ),
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 8.0,
                color: Colors.white,
              ),
            ),
          ),
          width: 30,
        ),
      );
    }

    return list;
  }

  Widget keyBoard() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Row(
            children: createLetter(0, 7),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: createLetter(8, 15),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: createLetter(16, 23),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: createLetter(24, 29),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ],
      ),
    );
  }

  List<Widget> createLetter(int startLetterindex, int lastLetterIndex) {
    List<Widget> list = [];
    List<String> letters = [
      "Q",
      "W",
      "E",
      "R",
      "T",
      "Z",
      "U",
      "I",
      "O",
      "P",
      "A",
      "S",
      "D",
      "F",
      "G",
      "H",
      "J",
      "K",
      "L",
      "Y",
      "X",
      "C",
      "V",
      "B",
      "N",
      "M",
      "Ä",
      "Ö",
      "Ü",
      "ß"
    ];

    for (var i = startLetterindex; i <= lastLetterIndex; i++) {
      list.add(
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 40, height: 30),
            child: ElevatedButton(
              child: Center(
                child: Text(
                  letters.elementAt(i),
                  style: TextStyle(fontSize: 15),
                ),
              ),
              onPressed: () {
                widget.wordController.guessLetter(letters.elementAt(i));
              },
            ),
          ),
        ),
      );
    }

    return list;
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => timer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => _duration = Duration(days: 5));
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = _duration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        timer!.cancel();
      } else {
        _duration = Duration(seconds: seconds);
      }
    });
  }
}
