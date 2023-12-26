import 'package:flutter/material.dart';
import 'package:shopping_list/views/new_item_screen.dart';

import 'package:shopping_list/widgets/grocery_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('You Groceries'),
      ),
      body: const GroceryList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewItem()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
