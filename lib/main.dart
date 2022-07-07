import 'package:flutter/material.dart';
import 'package:hangman/controller/wordController.dart';
import 'package:hangman/model/fetchWords.dart';
import 'package:hangman/model/player.dart';
import 'package:hangman/model/players.dart';
import 'package:hangman/model/words.dart';
import 'package:hangman/pages/startPage.dart';
import 'package:provider/provider.dart';
import 'package:localstore/localstore.dart';

void main() async {
  var list = await loadList();
  Words words = Words(wordList: list);
  WordController wordController = WordController.name(words);

  List<Player> playersList = [];
  Players players = Players(playersList);

  WidgetsFlutterBinding.ensureInitialized();
  var db = Localstore.instance;
  var tempID = await db.collection("players").get();
  print("Here");
  print(tempID);
  if (tempID == null){
    final id = db.collection("players").doc().id;
    db.collection("players").doc(id).set({
      "players": players
    });


  }

  runApp(MyApp(wordController, players, db));
}

class MyApp extends StatelessWidget {
  final WordController controller;
  final Players players;
  var db = Localstore.instance;

  MyApp(this.controller, this.players,this.db, {Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<Map<String, dynamic>?> items = db.collection("players").get();

    return ChangeNotifierProvider<WordController>(
      create: (_) => controller,
      child: MaterialApp(
        title: 'Homepage',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        home: StartPage(controller, players),
      ),
    );
  }
}


List<String> loadList(){
  List<String> list = [];
  ListOfWords().fetchWords().then((value) {
    list.addAll(value.getWordList);
  });
  return list;
}
