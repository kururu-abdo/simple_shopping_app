import 'package:myredux/domain/entities/cart.dart';
import 'package:myredux/domain/entities/invoice.dart';
import 'package:myredux/domain/entities/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
class DBHelper{
  static Database _db;
  static const String id ="id";
  static const String name ="name";
  static const String products ="products";
    static const String cartId ="cartId";

  static const String date ="date";
  static const String price ="price";
    static const String isPaid ="ispaid";
  static const String CartTable ="cart";
    static const String InvoiceTable ="invoice";
      static const String UserTabel ="user";
        static const String DBName ="shopping.db";
Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DBName);
    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version) async {
    try {
 await db.execute(
          "CREATE TABLE $UserTabel ($id INTEGER PRIMARY KEY   AUTOINCREMENT,$name TEXT    )");

  await db.execute(
          "CREATE TABLE $CartTable ($id INTEGER PRIMARY KEY  AUTOINCREMENT,$products TEXT    )");

   await db.execute(
          "CREATE TABLE $InvoiceTable ($id INTEGER PRIMARY KEY AUTOINCREMENT ,$date DATETIME   ,$price  REAL  ,$isPaid INTEGER )");

    }on DatabaseException {
      throw Exception();
    }
    }
    
    
    
    //Dao's
  
  //insert
Future<UserModel>  saveUser(UserModel model) async{
 var dbClient = await db;
    var result = await dbClient.insert(UserTabel, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return model;
}
Future<Cart>  saveCart(Cart model) async{
 var dbClient = await db;
    var result = await dbClient.insert(CartTable, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return model;
}
Future<Invoic>  saveInvoice(Invoic model) async{
 var dbClient = await db;
    var result =  dbClient.insert(InvoiceTable, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return model;
}
//update
  Future<int>  updateUser(UserModel model) async{
  var dbClient = await db;
  
  return await dbClient.update(UserTabel, model.toJson() ,where: "id=?" ,whereArgs: [model.id]);
  
  }
   Future<int> updateCart(Cart model) async{
  var dbClient = await db;

  return await dbClient.update(CartTable, model.toJson() ,where: "id=?" ,whereArgs: [model.id]);

  }
   Future<int>  updateInvoice(Invoic model) async{
  var dbClient = await db;

  return await dbClient.update(InvoiceTable, model.toJson() ,where: "id=?" ,whereArgs: [model.id]);

  }


  
  //delete
   Future<int> deleteUser(int id) async {
   var dbClient = await db;
    return await dbClient.delete(UserTabel, where: 'id = ?', whereArgs: [id]);
  }
   Future<int> deleteInvoice(int id) async {
   var dbClient = await db;



    return await dbClient.delete(InvoiceTable, where: 'id = ?', whereArgs: [id]);



  }
   Future<int> deleteCart(int id) async {
   var dbClient = await db;
    return await dbClient.delete(CartTable, where: 'id = ?', whereArgs: [id]);
  }

  
  
  
  
  //select
  
    Future<UserModel> getUser(int id) async {
   var dbClient = await db;
   UserModel user;
    List<Map> maps = await dbClient.query(UserTabel,

        where: 'id = ?',
        whereArgs: [id]);
     if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        user=   UserModel.fromJson(maps[i]);
      }

    }else{
       return null;
     }
    return user;
  }

  Future<List<Invoic>> getInvoices() async {
   var dbClient = await db;
   List<Invoic> invoices=[];
    List<Map> maps = await dbClient.query(InvoiceTable,
);
      if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        invoices.add(Invoic.fromJson(maps[i]));
      }

    }else{
        return null;
      }
    return invoices;
  }

  Future<Invoic> getInvoice(int id) async {
   var dbClient = await db;
   Invoic invoice;
    List<Map> maps = await dbClient.query(InvoiceTable,

        where: 'id = ?',
        whereArgs: [id]);
      if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        invoice=Invoic.fromJson(maps[i]);
      }

    }else{
        return null;
      }
    return invoice;
  }
  

  Future<Cart> getCart(int id) async {
   var dbClient = await db;
    Cart cart;
    List<Map> maps = await dbClient.query(CartTable,

        where: 'id = ?',
        whereArgs: [id]);
      if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        cart=Cart.fromJson(maps[i]);
      }

    }else{
        return null;
      }
    return cart;
  }

  Future<List<Cart>> getCarts() async {
   var dbClient = await db;
    List<Cart> carts;
    List<Map> maps = await dbClient.query(CartTable,

       );
      if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        carts.add(Cart.fromJson(maps[i]));
      }

    }else{
        return null;
      }
    return carts;
  }

  
  
  //close database object to avoid any memory leaks
 Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

}