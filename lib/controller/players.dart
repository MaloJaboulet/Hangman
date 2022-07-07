import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hangman/model/player.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Players extends ChangeNotifier {
  List<Player> _playersList = [];
  late SharedPreferences prefs;


  Players(List<Player> playersList) {
    WidgetsFlutterBinding.ensureInitialized();
    addPref();
    this._playersList = playersList;
  }

  Players.name(this._playersList);

    addPref() async {
      var temp = SharedPreferences.getInstance();
      prefs = await temp;
  }

  addPlayer(String name, int highscore) {
    print("++++++++++++++++++++++++++++++++++++++++++");
    Player player = Player(name, highscore);
    _playersList.add(player);
    prefs.setString("players", jsonEncode(_playersList.map((e) => e.toJson()).toList()));
    notifyListeners();
  }

  List<Player> get getList => List.unmodifiable(_playersList);

  Player getPlayer(String name) {
    for (var player in _playersList) {
      if (player.name == name) {
        return player;
      }
    }
    return Player("no player", 0);
  }

  printPlayer(){
    Iterable l = json.decode(prefs.get("players").toString());
    List<Player> list = List<Player>.from(l.map((model)=> Player.fromJson(model)));
    print(list.length);
  }
}
