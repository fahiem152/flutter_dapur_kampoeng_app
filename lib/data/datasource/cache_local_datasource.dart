import 'dart:developer';

import 'package:dapur_kampoeng_app/data/models/response/product_response_model.dart';
import 'package:dapur_kampoeng_app/presentation/home/models/order_model.dart';
import 'package:dapur_kampoeng_app/presentation/home/models/product_quantity.dart';
import 'package:dapur_kampoeng_app/presentation/settings/models/discount_model.dart';
import 'package:sqflite/sqflite.dart';

class CacheLocalDatasource {
  CacheLocalDatasource._init();

  static final CacheLocalDatasource instance = CacheLocalDatasource._init();

  final String tableProduct = 'products';
  final String tableOrder = 'orders';
  final String tableOrderItem = 'order_items';
  final String tableDiscount = 'discounts';

  static Database? _database;

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableProduct (
        id INTEGER PRIMARY KEY,
        productId INTEGER,
        name TEXT,
        categoryId INTEGER,
        categoryName TEXT,
        description TEXT,
        image TEXT,
        price TEXT,
        stock INTEGER,
        status INTEGER,
        isFavorite INTEGER,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableOrder (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        payment_amount INTEGER,
        sub_total INTEGER,
        tax INTEGER,
        discount INTEGER,
        discount_amount INTEGER,
        service_charge INTEGER,
        total INTEGER,
        payment_method TEXT,
        total_item INTEGER,
        id_kasir INTEGER,
        nama_kasir TEXT,
        transaction_time TEXT,
        is_sync INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableOrderItem (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_order INTEGER,
        id_product INTEGER,
        quantity INTEGER,
        price INTEGER
      )
    ''');
    await db.execute('''
    CREATE TABLE $tableDiscount (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        value INTEGER
      )
    ''');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dbresto21.db');
    return _database!;
  }

  Future<void> saveDiscount(List<DiscountModel> discounts) async {
    final db = await instance.database;
    for (var discount in discounts) {
      await db.insert(tableDiscount, discount.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      log('inserted success ${discount.name}');
    }
  }

  Future<List<DiscountModel>> getDiscounts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableDiscount);
    return List.generate(maps.length, (i) {
      return DiscountModel.fromLocalMap(maps[i]);
    });
  }

  //save order
  Future<void> saveOrder(OrderModel order) async {
    final db = await instance.database;
    int id = await db.insert(tableOrder, order.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    for (var item in order.orderItems) {
      await db.insert(tableOrderItem, item.toLocalMap(id),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  //get data order
  Future<List<OrderModel>> getOrderByIsNotSync() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(tableOrder, where: 'is_sync = ?', whereArgs: [0]);
    return List.generate(maps.length, (i) {
      return OrderModel.fromMap(maps[i]);
    });
  }

  //get order item by order id
  Future<List<ProductQuantity>> getOrderItemByOrderId(int orderId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db
        .query(tableOrderItem, where: 'id_order = ?', whereArgs: [orderId]);
    return List.generate(maps.length, (i) {
      return ProductQuantity.fromLocalMap(maps[i]);
    });
  }

  //update order is sync
  Future<void> updateOrderIsSync(int orderId) async {
    final db = await instance.database;
    await db.update(tableOrder, {'is_sync': 1},
        where: 'id = ?', whereArgs: [orderId]);
  }

  //insert data product
  Future<void> insertProduct(Product product) async {
    final db = await instance.database;
    await db.insert(tableProduct, product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //insert list of product
  Future<void> insertProducts(List<Product> products) async {
    final db = await instance.database;
    for (var product in products) {
      await db.insert(tableProduct, product.toLocalMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      log('inserted success ${product.name}');
    }
  }

  //get all products
  Future<List<Product>> getProducts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableProduct);
    return List.generate(maps.length, (i) {
      return Product.fromLocalMap(maps[i]);
    });
  }

  Future<List<OrderModel>> getAllOrder() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableOrder,
    );
    return List.generate(maps.length, (i) {
      return OrderModel.fromMap(maps[i]);
    });
  }

  //delete all products
  Future<void> deleteAllProducts() async {
    final db = await instance.database;
    await db.delete(tableProduct);
  }

  Future<void> deleteAllDiscounts() async {
    final db = await instance.database;
    await db.delete(tableDiscount);
  }

  Future<void> deleteAllOrders() async {
    final db = await instance.database;
    await db.delete(tableOrder);
  }

  Future<void> deleteAllOrderItems() async {
    final db = await instance.database;
    await db.delete(tableOrderItem);
  }
}
