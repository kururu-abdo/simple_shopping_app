
import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/components/button/gf_icon_button.dart';
import 'package:getflutter/components/card/gf_card.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:myredux/domain/entities/product.dart';
import 'package:myredux/service/interfaces/cart_services.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ProductUi extends StatelessWidget{
 final Products products;
  ProductUi(this.products);

  @override
  Widget build(BuildContext context) {
var cartModel = Injector.getAsReactive<CartService>(context: context);
    return  Card(
      color: Colors.tealAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Image.network(products.pic,height: 50,width:60 ,) ,
         Text(products.name),

         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
            Text("price:  ${products.price} SDG") ,

          GestureDetector(
            onTap: ()async{

               cartModel.setState((state)=>
            state.AddProducatToCart(products),
          catchError: true ,);



            },
            child: Material(
              elevation: 6.0,
              color: Colors.red[900],
child: Icon(Icons.add),
            ),

          )


         ],

         )


        ],



      ),


    );



      GFCard(

      color: Colors.tealAccent,
      image: Image.network(products.pic),
      title: GFListTile(
title: Text('${products.name}'),
      ),
 buttonBar: GFButtonBar(
      alignment: WrapAlignment.center,
      children: <Widget>[

        GFButton(
          onPressed: ()  async {
//       ///  cartModel.numberOfPrdouctIntoCart();
//         cartModel.AddProducatToCart(products);

          cartModel.setState((state)=>
            state.AddProducatToCart(products),
          catchError: true ,


          //  state.numberOfPrdouctIntoCart();



          );
          },
          text: 'addToCart',
          type: GFButtonType.solid,
        ),
     ],
   ),
    );


      GFCard(
      color: Colors.tealAccent,
    boxFit: BoxFit.contain,
    //image: Image.network(products.pic),
    title: GFListTile(
         avatar:GFAvatar(),
        title: Text('${products.name}'),
        icon: GFIconButton(
            onPressed: null,
            icon: Icon(Icons.favorite_border),
            type: GFButtonType.transparent,
        )
    ),
    content: Text("Some quick example text to build on the card"),
    buttonBar: GFButtonBar(
      alignment: WrapAlignment.center,
      children: <Widget>[
        GFButton(
          onPressed: ()  async {
//       ///  cartModel.numberOfPrdouctIntoCart();
//         cartModel.AddProducatToCart(products);

          cartModel.setState((state)=>
            state.AddProducatToCart(products),
          catchError: true ,


          //  state.numberOfPrdouctIntoCart();



          );
          },
          text: 'addToCart',
          type: GFButtonType.solid,
        ),
     ],
   ),
 );
  }

}