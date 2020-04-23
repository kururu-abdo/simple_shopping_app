import 'package:myredux/domain/entities/product.dart';
import 'package:myredux/service/interfaces/i_api.dart';

class ProductServices  {


  IApi api;


  ProductServices(this.api);



  Future<List<Products>> getProducts() async{
    return await api.getProducts();
  }

  Future<Products> getProduct(int id) async{
    return await api.getProsuct(id);

  }




}