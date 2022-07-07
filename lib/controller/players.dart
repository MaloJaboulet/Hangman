import 'dart:convert';

import 'package:hangman/model/player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Players {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static addPlayer(String name, int highscore) async {
    if (_preferences != null) {
      print("++++++++++++++++++++++++++++++++++++++++++");
      Player player = Player(name, highscore);
      List<Player> tempList = getPlayerList();
      if (!Players.containsPlayer(name)) {
        tempList.add(player);
        _preferences!.setString(
            "players", jsonEncode(tempList.map((e) => e.toJson()).toList()));
      }
    }
  }

  static bool containsPlayer(String name){
    if (_preferences != null) {
      var playersList = getPlayerList();
      for (var player in playersList) {
        if (player.name == name) {
          return true;
        }
      }
    }
    return false;
  }

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
        list.sort(sortComparison);
        return list;
      }
    }
    return [];
  }

  static int sortComparison(Player p1, Player p2) {
    final highScorePlayer1 = p1.highScore;
    final highScorePlayer2 = p2.highScore;
    if (highScorePlayer1 < highScorePlayer2) {
      return -1;
    } else if (highScorePlayer1 > highScorePlayer2) {
      return 1;
    } else {
      return 0;
    }
  }
}
