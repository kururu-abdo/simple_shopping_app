//TODO: implement the class

import 'dart:convert' as JSON;

import 'package:myredux/domain/entities/product.dart';
import 'package:myredux/service/exceptions/network_exception.dart';
import 'package:myredux/service/exceptions/product_exception.dart';
import 'package:myredux/service/interfaces/i_api.dart';
import 'package:http/http.dart' as http;
import 'package:myredux/ui/exceptions/ui_exceptions.dart';

class Api extends IApi{
  static const endpoint ='http://localhost:5544';

  @override
  Future<List<Products>> getProducts()  async{
    var response;
    try {
      response = await http.get('$endpoint/products');
    } catch (e) {
      //Handle network error
      //It must throw custom errors classes defined in the service layer
      throw NetWorkException("مشكلة في الشبكة");
    }
//Handle not found page
    if (response.statusCode == 404) {
      throw   ProductNotFoundEDxception("المنتج غير مودجود");
    }

    String body =JSON.utf8.decode(response.bodyBytes);
        Map<String ,dynamic>  data = JSON.jsonDecode(body);
//  print(data);
//    print(body);
    Product products;
    Iterable  I = data["products"];

    List<Products> product= I.map((i)=>Products.fromJson(i)).toList();
   // products =  Product.fromJson(data);
    print(product[0].price);
    //print(product[0].price);
//    products =Product.fromJson(data["products"]);
//    print(products.products.name);
return product;
  }

  @override
  Future<Products> getProsuct(int id)  async {
   var response;
    try {
      response = await http.get('$endpoint/products?id=$id');
    } catch (e) {
      //Handle network error
      //It must throw custom errors classes defined in the service layer
      throw NetWorkException("مشكلة في الشبكة");
    }
//Handle not found page
    if (response.statusCode == 404) {
      throw   ProductNotFoundEDxception("المنتج غير مودجود");
    }
Map<String , dynamic> data = JSON.jsonDecode(response.body);
    Products  products;
    products =Products.fromJson(data["product"]);
return products;
  }

  @override
  Future<void> userLogin(String name, password)  async{
 var response;
    try {
      response = await http.get('$endpoint/users?name=$name&password=$password');
    } catch (e) {
      //Handle network error
      //It must throw custom errors classes defined in the service layer
      throw NetWorkException("مشكلة في الشبكة");
    }
//Handle not found page
    if (response.statusCode == 404) {

      throw   ProductNotFoundEDxception(" المستخدم غير موجود");

    } if(response.body==null || response=="{}"){
      throw WrongCredentialsException("تأكد من كلمة المرور او اسم المستخدم");
    }
return true;
  }

}