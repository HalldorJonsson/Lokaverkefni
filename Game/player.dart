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
    inventory.add(item);
    print('--- --- ---');
    print('$item has been added to your inventory.');
    print('--- ^---^ ---');
  }
  void showInventory() {
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
      print('Choose a weapon by entering the number next to it:');
      String? input = stdin.readLineSync();
      if (input != null) {
        int? index = int.tryParse(input);
        if (index != null && index > 0 && index <= inventory.length) {
          return inventory[index - 1];
        }
      }
      print('Invalid choice. ');
      return '';
    }
  }
}
