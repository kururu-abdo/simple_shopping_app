import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getflutter/components/list_tile/gf_list_tile.dart';
import 'package:myredux/domain/entities/invoice.dart';
import 'package:myredux/domain/entities/product.dart';
import 'package:myredux/service/interfaces/cart_services.dart';
import 'package:myredux/service/interfaces/invoice_services.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class CartUi  extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
  var cartModel = Injector.getAsReactive<CartService>(context: context);
  var invoiceModel = Injector.getAsReactive<InvoiceService>(context: context);
return ListView(
  scrollDirection: Axis.vertical,
  children:[
    Container(
      height: 50,
      width: double.infinity,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Material(
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                cartModel.setState((state)=>
                state.closeCart()
                );
                 cartModel.setState((state)=>state.deleteCarts()

              );
              },
            ),
          ) ,


          Text("Cart" ,style: TextStyle(color: Colors.white ,fontSize: 15.0, fontWeight: FontWeight.bold),)

        ],
      ),

    ),
Container(
  height: 400,
  width: double.infinity,
  color: Colors.white,
  child: ListView(
    children:  List.generate(cartModel.state.getUniqeProducts().length, (index){
      var product= cartModel.state.getUniqeProducts()[index];

   return   Material(
      child: ListTile(
        title: Text(product.name),
        subtitle: Text("quantity:"+"${cartModel.state.getQuantity(product)} "),
        leading: Text("price: ${cartModel.state.getPriceofProduct(product)}"),
      ),
    );

    })

//    cartModel.state.myUniqueProducts().map((product)=>
//    Material(
//      child: ListTile(
//        title: Text(product.name),
//        subtitle: Text("quantity:"+"${cartModel.state.getQuantity(product)} "),
//        leading: Text("price: ${cartModel.state.getPriceofProduct(product)}"),
//      ),
//    )).toList(),
  ),


) ,
    Container(
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Material(
              elevation: 6.0,
              child: Text("total price:  ${cartModel.state.getTotalPrice()} SDG" ,style: TextStyle(fontSize: 20),)),

          GestureDetector(
            onTap: (){
               invoiceModel.setState((state)=>


               state.InsertInvoice(Invoic(cartModel.state.getTotalPrice())),
               catchError: true


             );
              cartModel.setState((state)=>state.deleteCarts()

              );

Navigator.of(context).pop();
            },
            child: Material(
              color: Colors.green.shade900,
              child: Text("BUY NOW" ,),

            ),
          )


        ],
      ),
    )
]
);
  }


}