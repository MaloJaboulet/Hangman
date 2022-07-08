import 'dart:convert';

import 'package:hangman/model/player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Players {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static addPlayer(String name, int highscore) async {
    if (_preferences != null) {
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

  static increaseHighscore(Player player){
    if (_preferences != null) {
      var playersList = getPlayerList();
      for (var player1 in playersList) {
        if (player1.name == player.name) {
          var index = playersList.indexOf(player1);
          playersList.removeAt(index);
          playersList.add(player);
        }
      }
      _preferences!.remove("players");
      _preferences!.setString(
          "players", jsonEncode(playersList.map((e) => e.toJson()).toList()));
    }
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
        var tempList = json.decode(_preferences!.get("players")
            .toString());

        List<Player> list =
          List<Player>.from(tempList.map((model) => Player.fromJson(model)));
        list.sort(sortComparison);
        return list;
      }
    }
    return [];
  }

  static int sortComparison(Player p1, Player p2) {
    final highScorePlayer1 = p1.highScore;
    final highScorePlayer2 = p2.highScore;
    if (highScorePlayer1 > highScorePlayer2) {
      return -1;
    } else if (highScorePlayer1 < highScorePlayer2) {
      return 1;
    } else {
      return 0;
    }
  }
}
