import 'package.dart';

class Room {
  final String name;
  String description;
  String item;
  final String searchResult;
  bool _enemy;
  bool _isLocked;
  final String? requiredKey;
  String? enemyDescription;
  List<Room> adjacentRooms = [];

  Room({
    required this.name,
    required this.description,
    required this.item,
    required this.searchResult,
    bool enemy = false,
    bool isLocked = false,
    this.requiredKey,
    this.enemyDescription,
  })  : _enemy = enemy,
        _isLocked = isLocked;

  void addAdjacentRoom(Room room) {
    adjacentRooms.add(room);
  }

  String search() {
    return searchResult;
  }

  bool get enemy => _enemy;
  set enemy(bool value) => _enemy = value;

  bool get isLocked => _isLocked;
  set isLocked(bool value) => _isLocked = value;
}

class Bedroom extends Room {
  final String pinCode = '0134';
  bool safeOpened = false;

  Bedroom({
    required String name,
    required String description,
    required String item,
    required String searchResult,
    required bool enemy,
  }) : super(
    name: name,
    description: description,
    item: item,
    searchResult: searchResult,
    enemy: enemy,
  );

  String enterPin(String pin) {
    if (safeOpened) {
      return 'The safe is already opened.';
    }
    if (pin == pinCode) {
      safeOpened = true;
      this.description = 'A bedroom with an ominous feeling. The safe is open.';
      return 'The safe is opened. You found a key inside.';
    } else {
      return 'Incorrect pin.';
    }
  }

  @override
  String search() {
    if (!safeOpened) {
      return 'You found nothing special.';
    } else {
      return searchResult;
    }
  }
}
  class GameMap {
  late Room basement;
  late Room hallway;
  late Room library;
  late Room kitchen;
  late Room garden;
  late Bedroom bedroom;
  Room? currentRoom;

  GameMap() { //map yfir herbergi með class requirements
  basement = Room(
  name: 'Basement',
  description: 'A dark and chilling basement, we need to get out of here.. NOW',
  item: 'Torn piece of paper (01)',
  searchResult: 'You found a torn piece of paper with "01" written on it.',
  enemy: false,
  );
  hallway = Room(
  name: 'Hallway',
  description: 'A dark hallway, where does this lead?',
  item: 'crowbar',
  searchResult: 'You found a crowbar laying up against the wall.',
  enemy: false,
  );
  library = Room(
  name: 'Library',
  description: 'A quiet library with a door leading into another room at the opposite end',
  item: 'Torn piece of paper (34)',
  searchResult: 'You found a torn piece of paper with "34" written on it.',
  enemy: false,
  );
  kitchen = Room(
  name: 'Kitchen',
  description: 'A kitchen with a backdoor, a way out??',
  item: 'knife',
  searchResult: 'You found a knife.',
  enemy: false,
  );
  garden = Room(
  name: 'Garden',
  description: 'You enter the garden and you finally get out of the strange house..BUT ..',
  item: 'Trophy',
  searchResult: 'Trophy, you won the game.',
  enemy: true,
  isLocked: true,
  requiredKey: 'key',
  enemyDescription: 'your companion starts shaking, growling and foaming from the mouth',
  );
  bedroom = Bedroom(
  name: 'Bedroom',
  description: 'A bedroom with an ominous feeling. There is a safe here.',
  item: 'key',
  searchResult: 'You found a key in the safe.',
  enemy: false,
  );

  currentRoom = basement;
  basement.addAdjacentRoom(hallway);
  hallway.addAdjacentRoom(basement);
  hallway.addAdjacentRoom(library);
  hallway.addAdjacentRoom(bedroom); // addAdjacent er snilld, credit to pétur
  library.addAdjacentRoom(hallway);
  library.addAdjacentRoom(kitchen);
  kitchen.addAdjacentRoom(library);
  kitchen.addAdjacentRoom(garden);
  garden.addAdjacentRoom(kitchen);
  bedroom.addAdjacentRoom(hallway);
  }

  void changeCurrentRoomByIndex(int userInput, User player) {
  if (currentRoom != null &&
  userInput >= 1 &&
  userInput <= currentRoom!.adjacentRooms.length) {
  Room nextRoom = currentRoom!.adjacentRooms[userInput - 1];
  if (nextRoom.isLocked) {
  if (player.inventory.contains(nextRoom.requiredKey)) {
  print('You used the ${nextRoom.requiredKey} to unlock the ${nextRoom.name}.');
  nextRoom.isLocked = false;
  currentRoom = nextRoom;
  print('You are now in: ${currentRoom!.name}');
  } else {
  print('The ${nextRoom.name} is locked. You need the ${nextRoom.requiredKey} to enter.');
  }
  } else {
  currentRoom = nextRoom;
  print('You are now in: ${currentRoom!.name}');
  }
  } else {
  print('Invalid choice.');
  }
  }
  }