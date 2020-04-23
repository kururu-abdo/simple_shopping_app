class WrongCredentialsException
    extends Error{
  final msg;
  WrongCredentialsException(this.msg);
}
class ProductNotFoundException  extends Error{
    final msg;
  ProductNotFoundException(this.msg);

}

class NetworkException  extends Error{
    final msg;
  NetworkException(this.msg);

}
