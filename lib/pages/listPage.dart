import 'package:flutter/material.dart';
import 'package:hangman/model/listOfWords.dart';
import 'package:hangman/model/words.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<Words> wordList;
  final myTextController = TextEditingController();

  //state vars

  @override
  void initState() {
    super.initState();
    wordList = ListOfWords().fetchWords();
  }

  @override
  Widget build(BuildContext context) {
    /*var cookies = Provider.of<Cookies>(context);
    String wisdom = cookies.cookieOfTheDay;*/

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Container();
                },
              ),
            );
          },
        ),
        title: const Center(child: Text("List")),
        actions: [
          IconButton(
              icon: Icon(Icons.view_headline_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Container();
                    },
                  ),
                );
              }),
        ],
      ),
      body: Column(
        children: [Expanded(child: listWords(context)), listForm(context)],
      ),
    );
  }

  Widget listWords(BuildContext context) {
    /*return Center(
      child: FutureBuilder<Words>(
        future: wordList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.wordsList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      title: Text(snapshot.data!.wordsList.elementAt(index))),
                );
              },
              //Text(snapshot.data!.words.first);
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        },
      ),
    );*/
    var words = Provider.of<Words>(context);
    return Center(
      child: ListView.builder(
        itemCount: words.wordsList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(title: Text(words.wordsList.elementAt(index))),
          );
        },
        //Text(snapshot.data!.words.first);
      ),
    );
  }

  Widget listForm(BuildContext context) {
    var wordlist = Provider.of<Words>(context);
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
                wordlist.add(myTextController.text);
                myTextController.clear();
              }
            },
            child: Text("add")),
      ],
    );
  }
}
