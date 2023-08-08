import 'package:flutter/material.dart';
import 'package:sqflite_demo/enums/menu_button.dart';
import 'package:sqflite_demo/utilities/infoMenuItem.dart';
import '../data/database_helper.dart';
import '../models/product.dart';

class ProductDetails extends StatefulWidget {
  final Product selectedProduct;

  const ProductDetails({super.key, required this.selectedProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var dbHelper = DatabaseHelper();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var unitPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // set the values
    nameController.text = widget.selectedProduct.name;
    descriptionController.text = widget.selectedProduct.description;
    unitPriceController.text = widget.selectedProduct.unitPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details : ${widget.selectedProduct.name}'),
        actions: buildAppBarButtons(),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              nameField(),
              descriptionField(),
              unitPriceField(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildAppBarButtons() {
    return [
      infoButton(context: context),
      PopupMenuButton<Options>(
        onSelected: menuOptions,
        itemBuilder: (context) => <PopupMenuEntry<Options>>[
          const PopupMenuItem(
            value: Options.update,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.update_outlined,
                  color: Colors.blue,
                ),
                SizedBox(width: 3.0),
                Text('Update'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: Options.delete,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.blue,
                ),
                SizedBox(width: 3.0),
                Text('Delete'),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  void menuOptions(Options option) {
    switch (option) {
      case Options.update:
        if (nameController.text.isNotEmpty &&
            descriptionController.text.isNotEmpty &&
            unitPriceController.text.isNotEmpty) {
          editProduct();
          Navigator.pop(context);
        }
        break;
      case Options.delete:
        dbHelper.delete(widget.selectedProduct.id);
        Navigator.pop(context);
        break;
    }
  }

  TextField nameField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Product Name',
        hintText: widget.selectedProduct.name,
      ),
      controller: nameController,
    );
  }

  TextField descriptionField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Product Description',
        hintText: widget.selectedProduct.description,
      ),
      controller: descriptionController,
    );
  }

  TextField unitPriceField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Product Unit Price',
        hintText: widget.selectedProduct.unitPrice.toString(),
      ),
      controller: unitPriceController,
    );
  }

  void editProduct() async {
    // set changes
    widget.selectedProduct.name = nameController.text;
    widget.selectedProduct.description = descriptionController.text;
    widget.selectedProduct.unitPrice = double.parse(unitPriceController.text);
    // update the changes on database
    await dbHelper.update(
      widget.selectedProduct,
    );
  }
}
