import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/database_helper.dart';
import 'package:sqflite_demo/screens/product_add.dart';
import 'package:sqflite_demo/screens/product_details.dart';
import '../models/product.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<StatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends State<StatefulWidget> {
  var dbHelper = DatabaseHelper();
  late List<Product> products;
  Product? selectedProduct;

  void _refreshData() async {
    var data = await dbHelper.getProducts();
    setState(() {
      products = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: buildProductList(),
      floatingActionButton: buildButtons(),
    );
  }

  Center buildProductList() {
    return Center(
      child: FutureBuilder<List<Product>>(
        future: dbHelper.getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Loading...'));
          }
          return snapshot.data!.isEmpty
              ? const Center(
                  child: Text('No Products in List.'),
                )
              : ListView(
                  children: snapshot.data!.map((product) {
                    return Center(
                      child: Card(
                        color: selectedProduct?.id == product.id
                            ? Colors.blueGrey
                            : Colors.white,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            child: Text(product.id.toString()),
                          ),
                          title: Text(product.name),
                          subtitle: Text(product.description),
                          trailing: Text('\$ ${product.unitPrice}'),
                          onTap: () {
                            setState(() {
                              if (selectedProduct == null) {
                                selectedProduct = product;
                              } else {
                                selectedProduct = null;
                              }
                            });
                          },
                        ),
                      ),
                    );
                  }).toList(),
                );
        },
      ),
    );
  }

  Row buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FloatingActionButton(
          onPressed: () => naviProductAdd(),
          tooltip: 'Add New Product',
          child: const Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: () => naviProductDetails(),
          tooltip: 'Product Details',
          child: const Icon(Icons.edit),
        ),
      ],
    );
  }

  void naviProductAdd() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductAdd(),
      ),
    ).then((_) {
      _refreshData();
    });
  }

  void naviProductDetails() async {
    selectedProduct != null
        ? await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetails(selectedProduct: selectedProduct!),
            ),
          ).then((_) {
            _refreshData();
            setState(() {
              selectedProduct = null;
            });
          })
        : showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text('Stop!'),
              content: Text('Firstly, tap on the product to be edited.'),
            ),
          );
  }
}
