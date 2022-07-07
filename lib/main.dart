import 'package:flutter/material.dart';
import 'package:hangman/controller/wordController.dart';
import 'package:hangman/model/fetchWords.dart';
import 'package:hangman/model/player.dart';
import 'package:hangman/controller/players.dart';
import 'package:hangman/model/words.dart';
import 'package:hangman/pages/startPage.dart';
import 'package:provider/provider.dart';


void main() async {
  var list = await loadList();
  Words words = Words(wordList: list);
  WordController wordController = WordController.name(words);

  WidgetsFlutterBinding.ensureInitialized();

  List<Player> playersList = [];
  //Players players = Players();
  await Players.init();
  runApp(MyApp(wordController));
}

class MyApp extends StatelessWidget {
  final WordController controller;

  MyApp(this.controller, {Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<WordController>(
      create: (_) => controller,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Homepage',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        home: StartPage(controller),
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
