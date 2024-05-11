import 'dart:io';
import 'main.dart';


class User { //breyta user?
  final String playerName;
  final String companionName;
  final String description;
  final Map<String, User> exits;
  final List<String> items;

  User({
    required this.playerName,
    required this.companionName,
    required this.description,
    required this.exits,
    required this.items,
  });

}
class Player { //????
  List<String> inventory = [];
}

class Game {
  late User currentRoom;
  late Map<String, User> rooms;
  late Player player;

}

//teikna upp room plan. Hvert fara exits og annað. (nýtt file?)