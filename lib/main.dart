import 'package:flutter/material.dart';
import 'package:hangman/controller/wordController.dart';
import 'package:hangman/model/fetchWords.dart';
import 'package:hangman/model/words.dart';
import 'package:hangman/pages/homepage.dart';
import 'package:provider/provider.dart';

void main() async {
  var list = await loadList();
  Words words = Words(wordList: list);
  WordController wordController = WordController.name(words);
  runApp(MyApp(wordController));
}

class MyApp extends StatelessWidget {
  final WordController controller;

  const MyApp(this.controller, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WordController>(
      create: (_) => controller,
      child: MaterialApp(
        title: 'Homepage',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        home: Homepage(controller),
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
