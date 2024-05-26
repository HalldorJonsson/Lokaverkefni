import 'package.dart';

void main() {
  void restartGame() {
    print('\nDo you want to restart the game? (yes/no)');
    String? restartChoice = stdin.readLineSync();
    if (restartChoice != null && restartChoice.toLowerCase() == 'yes') {
      main();
    } else {
      print('Giving up so easily? piff!');
      exit(0);
    }
  }

  print('Welcome to the game!');
  print('-------');

  // Byrjun / character creation
  print('Enter your character\'s name:');
  String playerName = stdin.readLineSync() ?? "";
  print('Enter your companion\'s name:');
  String companionName = stdin.readLineSync() ?? "";
  User player = User(playerName: playerName, companionName: companionName);

  GameMap gameMap = GameMap();
  print('The story starts with ${player.playerName} and ${player.companionName} in the ${gameMap.currentRoom!.name}. They have no memory of how they got there..');
  while (true) {
    print('\nCurrent Room: ${gameMap.currentRoom!.description}'); // sleppa þessu? room description kemur stundum tvisvar

    // final feis
    if (gameMap.currentRoom!.enemy) {
      if (gameMap.currentRoom!.name == 'Garden') {
        print('$companionName is turning into a zombie!');
        print('Do you want to attack? (yes/no)');
        String? attackChoice = stdin.readLineSync();
        if (attackChoice != null && attackChoice.toLowerCase() == 'yes') {
          String weapon = player.chooseWeapon();
          if (weapon == 'knife') {
            print('You attack with the knife and defeat $companionName who has turned into a zombie.');
            gameMap.currentRoom!.enemy = false;
          } else {
            print('You chose the wrong weapon. $companionName turns into a zombie and starts snarling at $playerName, suddenly $companionName attacks and eats you alive.');
            print('------');
            print('Game Over.');
            print('---Whomp Whomp---');
            restartGame(); // vitlaust choice, þú deyrð. restart?
            return;
          }
        } else {
          print('You chose not to attack. $companionName turns into a zombie and starts snarling at $playerName, suddenly $companionName attacks and eats you alive.');
          print('Game Over.');
          restartGame(); //bad choice, þú deyrð. restart?
          return;
        }
      } else {
        print('You encounter ${gameMap.currentRoom!.enemyDescription}.');
        print('Do you want to attack? (yes/no)');
        String? attackChoice = stdin.readLineSync();
        if (attackChoice != null && attackChoice.toLowerCase() == 'yes') {
          String weapon = player.chooseWeapon();
          if (weapon.isNotEmpty) {
            print('You attack with $weapon and defeat ${gameMap.currentRoom!.enemyDescription}!');
            gameMap.currentRoom!.enemy = false; //
          } else {
            print('You have no weapon to use!');
          }
        } else {
          print('You chose not to attack.');
        }
      }
    }

    print('Options:');
    for (var i = 0; i < gameMap.currentRoom!.adjacentRooms.length; i++) { //room choice val
      Room adjacentRoom = gameMap.currentRoom!.adjacentRooms[i];
      String lockedStatus = adjacentRoom.isLocked ? ' (Locked)' : '';
      print('${i + 1}: Move to ${adjacentRoom.name}${lockedStatus}');
    }

    int additionalOptionStartIndex = gameMap.currentRoom!.adjacentRooms.length + 1; //additional options valmöguleikar. (bæta við?) -------
    print('$additionalOptionStartIndex: Search the room');
    print('${additionalOptionStartIndex + 1}: Check inventory');
    print('Enter your choice:');

    String? input = stdin.readLineSync();
    if (input != null) {
      int? userInput = int.tryParse(input);
      if (userInput != null) {
        if (userInput >= 1 && userInput <= gameMap.currentRoom!.adjacentRooms.length) {
          gameMap.changeCurrentRoomByIndex(userInput, player);
        } else if (userInput == additionalOptionStartIndex) {
          String searchResult = gameMap.currentRoom!.search();
          print(searchResult);
          print('Do you want to take the item? yes/no');
          String? takeItem = stdin.readLineSync();
          if (takeItem != null && takeItem.toLowerCase() == 'yes') {
            player.addItem(gameMap.currentRoom!.item);}
        } else if (userInput == additionalOptionStartIndex + 1) {
          player.showInventory();
        } else {
          print('Invalid choice. Please enter a valid option.');
        }
      } else {
        print('Invalid choice. Please enter a number.');
      }
    }
  }
}