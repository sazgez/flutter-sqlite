import 'package:flutter/material.dart';
import 'package:sqflite_demo/validations/product_validator.dart';
import '../data/database_helper.dart';
import '../models/product.dart';

class ProductEdit extends StatefulWidget {
  final Product selectedProduct;

  const ProductEdit({super.key, required this.selectedProduct});

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> with ProductValidation {
  var dbHelper = DatabaseHelper();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          const PopupMenuItem(
            child: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              nameFormField(),
              descriptionFormField(),
              unitPriceFormField(),
              updateButton(),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField nameFormField() {
    return TextFormField(
      initialValue: widget.selectedProduct.name,
      decoration: InputDecoration(
        labelText: 'Product Name',
        hintText: widget.selectedProduct.name,
      ),
      validator: validateName,
      onSaved: (value) {
        widget.selectedProduct.name = value!;
      },
    );
  }

  TextFormField descriptionFormField() {
    return TextFormField(
      initialValue: widget.selectedProduct.description,
      decoration: InputDecoration(
        labelText: 'Product Description',
        hintText: widget.selectedProduct.description,
      ),
      validator: validateDescription,
      onSaved: (value) {
        widget.selectedProduct.description = value!;
      },
    );
  }

  TextFormField unitPriceFormField() {
    return TextFormField(
      initialValue: widget.selectedProduct.unitPrice.toString(),
      decoration: InputDecoration(
        labelText: 'Product Unit Price',
        hintText: widget.selectedProduct.unitPrice.toString(),
      ),
      validator: validateUnitPrice,
      onSaved: (value) {
        widget.selectedProduct.unitPrice = double.parse(value!);
      },
    );
  }

  TextButton updateButton() {
    return TextButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState?.save();
          editProduct();
          Navigator.pop(context);
        }
      },
      child: const Text('Update'),
    );
  }

  void editProduct() async {
    await dbHelper.update(
      widget.selectedProduct,
    );
  }
}
