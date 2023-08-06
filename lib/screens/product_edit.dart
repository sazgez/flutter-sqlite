import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import '../models/product.dart';

class ProductEdit extends StatefulWidget {
  final Product selectedProduct;

  const ProductEdit({super.key, required this.selectedProduct});

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  var dbHelper = DatabaseHelper();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var unitPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              buildNameField(),
              buildDescriptionField(),
              buildUnitPriceField(),
              buildUpdateButton(),
            ],
          ),
        ),
      ),
    );
  }

  TextField buildNameField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Product Name',
        hintText: widget.selectedProduct.name,
      ),
      controller: nameController,
    );
  }

  TextField buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Product Description',
        hintText: widget.selectedProduct.description,
      ),
      controller: descriptionController,
    );
  }

  TextField buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Product Unit Price',
        hintText: widget.selectedProduct.unitPrice.toString(),
      ),
      controller: unitPriceController,
    );
  }

  TextButton buildUpdateButton() {
    return TextButton(
      onPressed: () {
        editProduct();
        Navigator.pop(context);
      },
      child: const Text('Update'),
    );
  }

  void editProduct() async {
    if (nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        unitPriceController.text.isNotEmpty) {
      widget.selectedProduct.name = nameController.text;
      widget.selectedProduct.description = descriptionController.text;
      widget.selectedProduct.unitPrice = double.parse(unitPriceController.text);
      await dbHelper.update(
        widget.selectedProduct,
      );
    }
  }
}
