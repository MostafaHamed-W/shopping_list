import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/providers/grocery_items_provider.dart';

class GroceryList extends ConsumerWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceryItems = ref.watch(groceryListProvider);
    final groceryList = ref.read(groceryListProvider.notifier);
    return ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(index),
          onDismissed: (direction) {
            groceryList.removeItem(groceryItems[index].name);
          },
          child: ListTile(
            title: Text(groceryItems[index].name),
            leading: Container(
              height: 24,
              width: 24,
              color: groceryItems[index].category.color,
            ),
            trailing: Text("${groceryItems[index].quantity}"),
          ),
        );
      },
    );
  }
}
