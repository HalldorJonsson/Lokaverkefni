import 'package.dart';

class User {
  final String playerName;
  final String companionName;
  List<String> inventory = [];

  User({
    required this.playerName,
    required this.companionName,
  });

  void addItem(String item) {
    inventory.add(item); //bæta við bakpoka
    print('--- --- ---');
    print('$item has been added to your inventory.');
    print('--- ^---^ ---');
  }

  void showInventory() { //skoða bakpoka
    if (inventory.isEmpty) {
      print('--- --- ---');
      print('Your inventory is empty.');
      print('--- ^---^ ---');
    } else {
      print('--- --- ---');
      print('Your inventory contains:');
      print('--- --');
      for (int i = 0; i < inventory.length; i++) {
        print('${i + 1}: ${inventory[i]}');
      }
    }
  }

  String chooseWeapon() {
    if (inventory.isEmpty) {
      print('--- --- ---');
      print('Your inventory is empty. You have no weapon to choose.');
      print('--- --- ---');
      return '';
    } else {
      showInventory();
      print('Choose a weapon by number:');
      String? weaponChoice = stdin.readLineSync();
      int? index = int.tryParse(weaponChoice ?? '');
      if (index != null && index > 0 && index <= inventory.length) {
        return inventory[index - 1];
      } else {
        print('Invalid choice.');
        return '';
      }
    }
  }

  void breakWeapon(String weapon) {
    inventory.remove(weapon); //brjóta vopn
    print('$weapon broke.');
  }
}