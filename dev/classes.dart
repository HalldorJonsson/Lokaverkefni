






//OLD FILE TO BE DELETED --- Ignore this

import 'dart:io';
import 'main.dart';


class User {
  final String playerName;
  final String companionName;
//spilari

  User({
    required this.playerName,
    required this.companionName,
  });
}


  class Room {
  final String name;
  final String description;
  final Map<String, Room> exits;
  final List<String> items;
//herbergi
  Room({
  required this.name,
  required this.description,
  required this.exits,
  required this.items,
  });
  }


class Player { //bíða með inventory
  List<String> inventory = [];
}

class Game {
  late Room currentRoom;
  late Map<String, Room> rooms;
  late Player player;
//græja  hvert herbergi fara hvert. exits. bíða með items
  Game() {
    Room room1 = Room(
      name: 'herbergi 1....',
      description: 'svæði 1 ....',
      exits: {},
      items: ['key'],
    );

}
}
//teikna upp room plan. Hvert fara exits og annað. (nýtt file?)
