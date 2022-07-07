import 'package:flutter/material.dart';
import 'package:hangman/controller/wordController.dart';
import 'package:hangman/model/fetchWords.dart';
import 'package:hangman/model/words.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  WordController wordController;

  ListPage(this.wordController);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final myTextController = TextEditingController();

  //state vars

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("List")),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(null),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: listWords(widget.wordController)),
          listForm(widget.wordController)
        ],
      ),
    );
  }

  Widget listWords(WordController controller) {
    //var controller = Provider.of<WordController>(context);
    return Center(
      child: ListView.builder(
        itemCount: controller.getWords.getWordList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                title: Text(controller.getWords.getWordList.elementAt(index))),
          );
        },
        //Text(snapshot.data!.words.first);
      ),
    );
  }

  Widget listForm(WordController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: myTextController,
          decoration: const InputDecoration(
            labelText: 'Enter your word',
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 5)),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (myTextController.text.isNotEmpty) {
                controller.add(myTextController.text);
                myTextController.clear();
              }
            },
            child: Text("add")),
      ],
    );
  }
}
