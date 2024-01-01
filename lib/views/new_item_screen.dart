import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/providers/grocery_items_provider.dart';
import 'package:uuid/uuid.dart';

class NewItem extends ConsumerStatefulWidget {
  const NewItem({super.key});

  @override
  ConsumerState<NewItem> createState() => _NewItemState();
}

class _NewItemState extends ConsumerState<NewItem> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemCountController = TextEditingController();
  Categories? selectedItem = Categories.carbs;
  List<Categories> categoriesNames = [
    ...Categories.values.map((category) {
      return category;
    }).toList()
  ];

  final uuid = const Uuid();

  final _formKey = GlobalKey<FormState>();
  Category selectedCategory = categories.entries.first.value;

  void saveItem() async {
    if (_formKey.currentState!.validate() == true) {
      _formKey.currentState!.save();
      ref.read(groceryListProvider.notifier).addNewItem(
            id: uuid.v4(),
            name: _itemNameController.text,
            quantity: _itemCountController.text,
            category: selectedCategory,
          );
      Navigator.pop(context);
    } else {}
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  // should return null if the validation succeded
                  // if validation failed should return validation error message
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length >= 50) {
                    return 'Please enter a valid name';
                  } else {
                    return null;
                  }
                },
                maxLength: 50,
                controller: _itemNameController,
                decoration: const InputDecoration(
                  label: Text(
                    'Name',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Please Enter a valid quantity!';
                        } else {
                          return null;
                        }
                      },
                      // initialValue: '1',
                      controller: _itemCountController,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: selectedCategory,
                      items: [
                        for (var category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  height: 24,
                                  width: 24,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 30),
                                Text(category.value.title)
                              ],
                            ),
                          )
                      ],
                      onChanged: (value) {
                        selectedCategory = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text('Reset'),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: saveItem,
                      child: const Text('Add'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
