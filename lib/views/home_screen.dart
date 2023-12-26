import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/providers/grocery_items_provider.dart';
import 'package:shopping_list/widgets/grocery_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemCountController = TextEditingController();
  Categories? selectedItem = Categories.carbs;
  List<Categories> categoriesNames = [
    ...Categories.values.map((category) {
      return category;
    }).toList()
  ];

  @override
  void dispose() {
    _itemNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('You Groceries'),
      ),
      body: Column(
        children: [
          const Expanded(
            child: GroceryList(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: _itemNameController,
                    decoration: const InputDecoration(
                      label: Text(
                        'Name',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButton(
                    isExpanded: true,
                    hint: const Text('Select Categoty'),
                    value: selectedItem,
                    items: categoriesNames
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(item.name),
                          ),
                        )
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedItem = newValue;
                      });
                    },
                  ),
                  TextField(
                    controller: _itemCountController,
                    decoration: const InputDecoration(
                      label: Text(
                        'Count',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(groceryListProvider.notifier).addNewItem(
                id: '1',
                name: _itemNameController.text,
                quantity: int.parse(_itemCountController.text),
                category: categories[selectedItem]!,
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
