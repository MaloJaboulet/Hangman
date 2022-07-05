import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hangman/model/words.dart';
import 'package:hangman/pages/listPage.dart';
import 'package:shake/shake.dart';

class Homepage extends StatefulWidget {
  Words data;

  Homepage(this.data);

  @override
  _HomepageState createState() => _HomepageState();

}

class _HomepageState extends State<Homepage> {
  late String word = "";

  //state vars
  forceRedraw() {
    setState(() => {});
  }

  @override
  void initState() {
    super.initState();
    word = widget.data.getWord;

    ShakeDetector.autoStart(
      onPhoneShake: () {

      },
    );
  }

  @override
  Widget build(BuildContext context) {

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
                      return ListPage();
                    },
                  ),
                );
              }),
        ],
      ),
      body: Column(
        children: [
          Image.asset('assets/images/hangman1.png'),
        ],
      ),
    );
  }
}
