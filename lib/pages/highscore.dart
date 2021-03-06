import 'package:flutter/material.dart';
import 'package:hangman/controller/players.dart';
import 'package:hangman/controller/wordController.dart';

class HighscorePage extends StatefulWidget {

  @override
  _HighscorePageState createState() => _HighscorePageState();
}

class _HighscorePageState extends State<HighscorePage> {

  //state vars

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Highscore")),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(null),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: listPlayers()),
        ],
      ),
    );
  }

  Widget listPlayers() {

    return Center(
      child: ListView.builder(
        itemCount: Players.getPlayerList().length,
        itemBuilder: (context, index) {
          print(Players.getPlayerList().last.name.toString());
          return Card(
              child: ListTile(
              title: Row(children: [Text(Players.getPlayerList()
              .elementAt(index)
              .name), Text(Players.getPlayerList().elementAt(index).highScore.toString())],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
              ),
          );
        },
        //Text(snapshot.data!.words.first);
      ),
    );
  }
}
