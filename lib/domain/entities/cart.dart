import 'product.dart';

class Cart{
  int id;
  Products products;
  Cart(this.id,this.products);

  Cart.fromJson(Map<String ,dynamic> json){
    id=json['id'];
    products=json['product'];
  }


 Map<String , dynamic> toJson(){
    return {
      'id':id,
      'products':products
    };
 }
}