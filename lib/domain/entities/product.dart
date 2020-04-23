class Product {
  Products products;

  Product({this.products});

  Product.fromJson(Map<String, dynamic> json) {
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.toJson();
    }
    return data;
  }
}


class Products {
  int id;
  String name;
  num price;
  String pic;

  Products({this.id, this.name, this.price, this.pic});

  Products.fromJson(Map<String, dynamic> json) {

        id = json['id'];
    name = json['name'];
    price = json['price'];
    pic = json['pic'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['pic'] = this.pic;
    return data;
  }
}
