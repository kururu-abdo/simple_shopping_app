class ProductNotFoundException extends Error{
  final msg;

  ProductNotFoundException(this.msg);
}