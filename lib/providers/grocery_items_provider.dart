import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

final groceryListProvider = StateNotifierProvider<GroceryNotifier, List<GroceryItem>>(
  (ref) => GroceryNotifier(),
);

class GroceryNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryNotifier()
      : super([
          GroceryItem(id: 'a', name: 'Milk', quantity: 1, category: categories[Categories.dairy]!),
          GroceryItem(
              id: 'b', name: 'Bananas', quantity: 5, category: categories[Categories.fruit]!),
          GroceryItem(
              id: 'c', name: 'Beef Steak', quantity: 1, category: categories[Categories.meat]!),
        ]);

  void addNewItem(
      {required String id,
      required String name,
      required int quantity,
      required Category category}) {
    state = [
      ...state,
      GroceryItem(id: id, name: name, quantity: quantity, category: category),
    ];
  }

  void removeItem(name) {
    state = state.where((element) => name != element.name).toList();
  }
}
