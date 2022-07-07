import 'package:flutter/material.dart';
import 'package:hangman/controller/wordController.dart';
import 'package:hangman/controller/players.dart';
import 'package:hangman/pages/highscore.dart';
import 'package:hangman/pages/homepage.dart';

class StartPage extends StatefulWidget {
  late WordController _wordController;


  StartPage(WordController controller) {
    _wordController = controller;
  }

  StartPage.name(this._wordController);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final myTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Hangman"),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(null),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HighscorePage();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: myTextController,
            decoration: const InputDecoration(
              labelText: 'Enter your Name',
              border: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5)),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (myTextController.text.isNotEmpty) {
                  String playerName = myTextController.text;
                  Players.addPlayer(playerName, 0);
                  myTextController.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Homepage(
                            widget._wordController,
                            Players.getPlayer(playerName),);
                      },
                    ),
                  );
                }
              },
              child: Text("Start")),
        ],
      ),
    );
  }
}
