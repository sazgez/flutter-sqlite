import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'eTrade.db');
    return await openDatabase(
      path,
      version: 1,
      singleInstance: true,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        unitPrice REAL
      )
    ''');
  }

  Future<List<Product>> getProducts() async {
    // get a reference to the database.
    Database db = await database;
    // query the table for all the products.
    var products = await db.query('products', orderBy: 'id');
    // create the products as a list of maps.
    List<Product> productList = products.isNotEmpty
        ? products.map((p) => Product.fromMap(p)).toList()
        : [];
    return productList;
  }

  Future<void> insert(Product product) async {
    // get a reference to the database.
    Database db = await database;
    // insert the given product.
    await db.insert(
      'products',
      product.toMap(),
    );
  }

  Future<void> delete(int id) async {
    // get a reference to the database.
    Database db = await database;
    // delete the given product from the database.
    await db.delete(
      'products',
      where: 'id = ?', // ensure that the product has a matching id.
      whereArgs: [
        id
      ], // pass the product's id as a whereArg to prevent SQL injection.
    );
    // another way:
    /*
    await db.rawDelete(
      'DELETE FROM products WHERE id= $id',
    );
    */
  }

  Future<void> update(Product product) async {
    // get a reference to the database.
    Database db = await database;
    // update the given product.
    await db.update(
      'products',
      product.toMap(),
      where: 'id = ?', // ensure that the product has a matching id.
      whereArgs: [
        product.id
      ], // pass the product's id as a whereArg to prevent SQL injection.
    );
  }
}
