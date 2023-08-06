import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/database_helper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<StatefulWidget> createState() => _ProductAddState();
}

class _ProductAddState extends State<StatefulWidget> {
  var dbHelper = DatabaseHelper();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var unitPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  TextField buildNameField() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Product Name'),
      controller: nameController,
    );
  }

  TextField buildDescriptionField() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Product Description'),
      controller: descriptionController,
    );
  }

  TextField buildUnitPriceField() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Product Unit Price'),
      controller: unitPriceController,
    );
  }

  buildSaveButton() {
    return TextButton(
      child: const Text('Save'),
      onPressed: () {
        addProduct();
        Navigator.pop(context);
      },
    );
  }

  void addProduct() async {
    if (nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        unitPriceController.text.isNotEmpty) {
      await dbHelper.insert(
        Product(
          name: nameController.text,
          description: descriptionController.text,
          unitPrice: double.parse(unitPriceController.text),
        ),
      );
    }
  }
}
