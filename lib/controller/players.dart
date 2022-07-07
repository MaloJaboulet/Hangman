import 'dart:convert';

import 'package:hangman/model/player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Players {
  //List<Player> _playersList;
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static addPlayer(String name, int highscore) async {
    if (_preferences != null) {
      print("++++++++++++++++++++++++++++++++++++++++++");
      Player player = Player(name, highscore);
      List<Player> tempList = getPlayerList();
      tempList.add(player);
      //_playersList.add(player);
      _preferences!.setString(
          "players", jsonEncode(tempList.map((e) => e.toJson()).toList()));
    }
    //notifyListeners();
  }

  //List<Player> get getList => List.unmodifiable(_playersList);

  static Player getPlayer(String name) {
    if (_preferences != null) {
      var playersList = getPlayerList();
      for (var player in playersList) {
        if (player.name == name) {
          return player;
        }
      }
    }
    return Player("no player", 0);
  }

  static List<Player> getPlayerList() {
    if (_preferences != null) {
      if (_preferences!.get("players") != null) {
        Iterable l = json.decode(_preferences!.get("players")
            .toString());
        List<Player> list =
        List<Player>.from(l.map((model) => Player.fromJson(model)));
        return list;
      }
    }
    return [];
  }
}
