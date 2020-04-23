import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:myredux/dataSources/local_database.dart';
import 'package:myredux/domain/entities/cart.dart';
import 'package:myredux/domain/entities/invoice.dart';
import 'package:myredux/domain/entities/product.dart';
import 'package:queries/collections.dart';
import 'package:rxdart/rxdart.dart';


class CartService{
 final DBHelper db;
 CartService(this.db);
 PublishSubject<List<Cart>> _carts= new  PublishSubject<List<Cart>>();
  PublishSubject<List<Cart>>  get carts =>  _carts.stream;
  PublishSubject<Cart> _cart= new  PublishSubject<Cart>();
  PublishSubject<Cart>  get cart =>  _cart.stream;
double totalPrice=0.0;
int quantity=0;

Observable<List<Products>> products;
PublishSubject<List<Products>> _myProducts = new  PublishSubject<List<Products>> ();
Stream<List<Products>>  get myProducts=> _myProducts.stream;

List<Products> _cartProducts=[];
List<Products> get cartProducts=>_cartProducts;
int _length=0;
int get length=>_length;
bool _cartButtonClicked=false;
bool get cartButtonClicked =>_cartButtonClicked;
List<Products> _uniqueCartProducts;
List<Products> get uniqueCartProducts=>_uniqueCartProducts;

AddProducatToCart(Products product){

  _cartProducts.add(product);
  List<Products> unique=_cartProducts.toSet().toList();
  _uniqueCartProducts=unique.toSet().toList();
  _length= _cartProducts.length;
  print(_uniqueCartProducts.length);
}
deleteCarts(){
  _myProducts.sink.add([]);
  _cartProducts=[];
  _length=_cartProducts.length;
  _uniqueCartProducts=_cartProducts.toSet().toList();

}

List<Products>  myUniqueProducts(){
  var allProducts =_cartProducts;
  var uniques = new LinkedHashMap<Products, bool>();
  for (var s in allProducts) {
  uniques[s] = true;
}
  List<Products> uniqueProducts=[];
for (var key in uniques.keys) {
  uniqueProducts.add(key);
}

return uniqueProducts;
}

openCart(){
  _cartButtonClicked=true;
}
closeCart(){
  _cartButtonClicked=false;
}

int getQuantity(Products products){
int  quntity;
quntity= List.of(_cartProducts).where((p)=>p==products).length;

return quntity;

}
List<Products>  get uniqe_products=> Collection(_cartProducts).distinct().toList();

List<Products> getUniqeProducts(){

 return _uniqueCartProducts;
}
int numberOfPrdouctIntoCart(){
   List<Products>  products;
   int  length ;
length=cartProducts.length;



  return length??0;
}
double getTotalPrice(){
double total=0.0;
    for(int i=0;i<cartProducts.length;i++){
       total+=_cartProducts[i].price;
    }
   return total;

  

  
}
double getPriceofProduct(Products products){
  double price =0.0;
 List<Products> product =List.of(_cartProducts).where((p)=>products==p).toList();
 for(int i =0;i<product.length;i++){
   price+=product[i].price;
 }

 return price;
  
  
}



void dispose(){
  _myProducts.close();
  _carts.close();
  _cart.close();
}
}