import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/providers/grocery_items_provider.dart';
import 'package:shopping_list/views/new_item_screen.dart';

import 'package:shopping_list/widgets/grocery_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceryList = ref.watch(groceryListProvider);

    Widget content = const Center(
      child: Text('There is no groceries'),
    );

    if (groceryList.isNotEmpty) {
      content = const GroceryList();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('You Groceries'),
      ),
      body: content,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewItem()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
