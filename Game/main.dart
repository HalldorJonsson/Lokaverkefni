import 'package.dart';

void main() {//failure, endurhlaða og byrja aftur
  void restartGame() {
    print('\nDo you want to restart the game? (yes/no)'
    );
    String? restartChoice = stdin.readLineSync();
    if (restartChoice != null && restartChoice.toLowerCase() == 'yes'
    ) {
      main();
    } else {
      print('Giving up so easily? piff!');
      exit(0);
    }
  }

  void endGame() {
    print('Congratulations, you\'ve won the first part, stay tuned for part 2...'
    );
    exit(0); //búinn með leikinn exit 0
  }

  print('Welcome to the game!'
  );
  print('-------');

  print('Enter your name:'
  );
  String? playerName = stdin.readLineSync();
  playerName = playerName ?? 'Player';
//ef ekkert er valið verða players skírðir player og companion as default
  print('Enter your companion\'s name:'
  );
  String? companionName = stdin.readLineSync();
  companionName = companionName ?? 'Companion';

  User player = User(playerName: playerName, companionName: companionName);
  GameMap gameMap = GameMap();
  bool kitchenRatDefeated = false;

  print('---');
  print('${player.playerName} and ${player.companionName} wake up in the ${gameMap.currentRoom!.name}. They have no memory of how they got there..');
  while (true) { //main lúppan while true þá sýnir það current room name
    print('\nCurrent Room: ${gameMap.currentRoom!.name}');
    print(gameMap.currentRoom!.description);
    if (gameMap.currentRoom!.name == 'Kitchen' && !kitchenRatDefeated) {
      print('A large rat jumps out and bites ${player.companionName}!'
      );
      print('The rat looks sickly and rabid its eyes glowing with a strange, unnatural light.'
      );
      gameMap.currentRoom!.enemy = true; //test enemy encounter.. tbd
      gameMap.currentRoom!.enemyDescription = 'a sickly, rabid rat';
      print('Do you want to attack? (yes/no)');
      String? attackChoice = stdin.readLineSync();
      if (attackChoice != null && attackChoice.toLowerCase() == 'yes') {
        String weapon = player.chooseWeapon();
        if (weapon == 'knife' || weapon == 'crowbar') {
          print('You attack with the $weapon and defeat the rabid rat but $companionName is hurt, you must escape quickly.'
          );
          kitchenRatDefeated = true;
          gameMap.currentRoom!.enemy = false;
          player.breakWeapon(weapon);
        } else {
          print('The weapon you chose is not effective. The rat bites you too and you both turn into zombies (and live happily forver after)'
          );
          print('Game Over.');
          restartGame();
          return;
        }
      } else {
        print('You chose not to attack. The rat bites you too and you both turn into zombies (and live happily forver after).'
        );
        print('Game Over.');
        restartGame();
        return;
      }
    } else if (gameMap.currentRoom!.enemy) {
      if (gameMap.currentRoom!.name == 'Garden') {
        print('${player.companionName} is turning into a zombie!'
        );
        print('Do you want to attack $companionName? (yes/no)'
        );
        String? attackChoice = stdin.readLineSync();
        if (attackChoice != null && attackChoice.toLowerCase() == 'yes') {
          String weapon = player.chooseWeapon();
          if (weapon == 'knife' || weapon == 'crowbar') {
            print('You attack with the $weapon and defeat ${player.companionName} who has turned into a zombie.'
            );
            gameMap.currentRoom!.enemy = false;
            player.breakWeapon(weapon);
          } else {
            print('You chose the wrong weapon. ${player.companionName} turns into a zombie and attacks you.'
            );
            print('------');
            print('Game Over.');
            print('---Whomp Whomp---');
            restartGame();
            return;
          }
        } else {
          print('You chose not to attack. ${player.companionName} turns into a zombie and attacks you.');
          print('Game Over.');
          restartGame();
          return;
        }
      } else {
        print('You encounter ${gameMap.currentRoom!.enemyDescription}.'
        );
        print('Do you want to attack? (yes/no)');
        String? attackChoice = stdin.readLineSync();
        if (attackChoice != null && attackChoice.toLowerCase() == 'yes') {
          String weapon = player.chooseWeapon();
          if (weapon == 'knife' || weapon == 'crowbar') {
            print('You attack with $weapon and defeat ${gameMap.currentRoom!.enemyDescription}!'
            );
            gameMap.currentRoom!.enemy = false;
            player.breakWeapon(weapon);
          } else {
            print('The weapon you chose is not effective. The enemy attacks you.'
            );
          }
        } else {
          print('You chose not to attack.'
          );
        }
      }
    }
    print('Options:'); //valmöguleikar eftir herbergi
    for (var i = 0; i < gameMap.currentRoom!.adjacentRooms.length; i++) {
      Room adjacentRoom = gameMap.currentRoom!.adjacentRooms[i];
      String lockedStatus = adjacentRoom.isLocked ? ' (Locked)' : '';
      print('${i + 1}: Move to ${adjacentRoom.name}${lockedStatus}');
    }
    int additionalOptionStartIndex = gameMap.currentRoom!.adjacentRooms.length + 1;
    print('---------');
    if (gameMap.currentRoom is! Bedroom) {
      print('$additionalOptionStartIndex: Search the room'
      );
    }
    print('${additionalOptionStartIndex + 1}: Check inventory'
    );
    if (gameMap.currentRoom is Bedroom) {
      print('${additionalOptionStartIndex + 2}: Enter pin to open the safe'
      );
    }
    print('Enter your choice:');
    String? input = stdin.readLineSync();
    if (input != null) {
      int? userInput = int.tryParse(input);
      if (userInput != null) {
        if (userInput >= 1 && userInput <= gameMap.currentRoom!.adjacentRooms.length) {
          gameMap.changeCurrentRoomByIndex(userInput, player);
        } else if (userInput == additionalOptionStartIndex) {
          String searchResult = gameMap.currentRoom!.search(); //leit eftir herbergi print result og choice
          print(searchResult);
          print('Do you want to take the item? yes/no');
          String? takeItem = stdin.readLineSync();
          if (takeItem != null && takeItem.toLowerCase() == 'yes') {
            player.addItem(gameMap.currentRoom!.item);
            if (gameMap.currentRoom!.item.toLowerCase() == 'trophy') {
              endGame();
            }
          }
        } else if (userInput == additionalOptionStartIndex + 1) {
          player.showInventory(); //inventory check
        } else if (userInput == additionalOptionStartIndex + 2 && gameMap.currentRoom is Bedroom) {
          print('Enter the pin to open the safe:');
          String? pin = stdin.readLineSync();
          if (pin != null) {
            Bedroom bedroom = gameMap.currentRoom as Bedroom;
            String result = bedroom.enterPin(pin);
            print(result);
            if (bedroom.safeOpened) {
              player.addItem(bedroom.item);
            }
          }
        } else {
          print('Invalid choice. Please enter a valid option.');
        }
      } else {
        print('Invalid choice. Please enter a number.');
      }
    }
  }
}//laga til í main, gera nýtt file