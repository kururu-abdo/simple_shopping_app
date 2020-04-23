import 'package:myredux/domain/entities/product.dart';

abstract class IApi{
  Future<List<Products>> getProducts();
  Future<Products> getProsuct(int id);
Future<void> userLogin(String name,password);
}