import 'package:flutter/material.dart';
import 'package:hangman/model/fetchWords.dart';
import 'package:hangman/model/words.dart';
import 'package:hangman/pages/homepage.dart';
import 'package:provider/provider.dart';

void main() async {
  var list = await loadList();
  Words words = Words(wordList: list);
  runApp(MyApp(words));
}

class MyApp extends StatelessWidget {
  final Words data;

  const MyApp(this.data, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Words>(
      create: (_) => data,
      child: MaterialApp(
        title: 'Homepage',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        home: Homepage(data),
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
