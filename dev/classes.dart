import 'dart:io';
import 'main.dart';


class User {
  //breyta user?
  final String playerName;
  final String companionName;

  User({
    required this.playerName,
    required this.companionName,
    //required this.description,
    //required this.exits,
    //required this.items,
  });
}
  class Room {
  final String name;
  final String description;
  final Map<String, Room> exits;
  final List<String> items;

  Room({
  required this.name,
  required this.description,
  required this.exits,
  required this.items,
  });
  }


class Player { //????
  List<String> inventory = [];
}

class Game {
  late Room currentRoom;
  late Map<String, Room> rooms;
  late Player player;

  Game() {
    // Define rooms
    Room room1 = Room(
      name: 'Room 1',
      description: 'You are in room 1. There is a door to the north.',
      exits: {},
      items: ['key'],
    );

}


}
//teikna upp room plan. Hvert fara exits og annað. (nýtt file?)