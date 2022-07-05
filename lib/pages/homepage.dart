import 'package:flutter/material.dart';
import 'package:hangman/model/listOfWords.dart';
import 'package:hangman/model/words.dart';
import 'package:shake/shake.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<Words> wordList;

  //state vars
  forceRedraw() {
    setState(() => {});
  }

  @override
  void initState() {
    super.initState();
    wordList = ListOfWords().fetchWords();

    ShakeDetector.autoStart(
      onPhoneShake: () {
        forceRedraw();
      },
    );
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
        title: const Center(child: Text("Hangman")),
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
        children: [
          Image.asset('assets/images/hangman1.png'),
          Expanded(child: lineWord(context)),
        ],
      ),
    );
  }

  Widget lineWord(BuildContext context) {
    return Center(
      child: FutureBuilder<Words>(
        future: wordList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.words.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      title: Text(snapshot.data!.words.elementAt(index))),
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
    );
  }
}
