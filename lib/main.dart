import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/getflutter.dart';
import 'package:myredux/dataSources/api.dart';
import 'package:myredux/dataSources/local_database.dart';
import 'package:myredux/domain/entities/product.dart';
import 'package:myredux/service/interfaces/authentication_service.dart';
import 'package:myredux/service/interfaces/authentication_service.dart';
import 'package:myredux/service/interfaces/cart_services.dart';
import 'package:myredux/service/interfaces/i_api.dart';
import 'package:myredux/service/interfaces/invoice_services.dart';
import 'package:myredux/service/interfaces/product_services.dart';
import 'package:myredux/service/interfaces/shared_pref_services.dart';
import 'package:myredux/ui/pages/login_page.dart';
import 'package:myredux/ui/pages/splash_screen.dart';
import 'package:myredux/ui/widgets/cart_ui.dart';
import 'package:myredux/ui/widgets/invoice_ui.dart';
import 'package:myredux/ui/widgets/logout_button.dart';
import 'package:myredux/ui/widgets/product_ui.dart';

import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'service/interfaces/authentication_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {






    return Injector(
            inject: [
              Inject<IApi>(() => Api()),

     Inject(()=>DBHelper()),

                 Inject(()=>CartService(Injector.get())),
                   Inject(()=>InvoiceService(Injector.get())),
     Inject(()=>AuthenticationServices(Injector.get())),
       Inject(()=>SharedPrefServices()),
Inject(()=>ProductServices(Injector.get())),
            ],
            builder:(_)=>  MaterialApp(
        title: 'shopping app',
        debugShowCheckedModeBanner: false,
routes: {
          Login.id:(context)=>Login(),
   HomePage.id:(context)=>Login(),
},
        home:SplashScreen() ,



            ),


    );
  }
}
class HomePage extends StatefulWidget{
static const id ="home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

String  name;
String user_image;
var email ;
getUserData()async{
  SharedPreferences mydata =await SharedPreferences.getInstance();
 setState(() {
    name=mydata.getString(USER_NAME);
    email=mydata.getString(USER_EMAIL)??"";
    user_image=   mydata.getString(USER_PROFILE);
 });
return mydata;
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
var productModel =Injector.get<ProductServices>();
var cartModel =Injector.getAsReactive<CartService>(context: context);
var height= MediaQuery.of(context).size.height;

    return Stack(
      children:[

        Builder(
          builder: (_){
            if(cartModel.connectionState==ConnectionState.waiting){
return CircularProgressIndicator();
            }
            if(cartModel.connectionState==ConnectionState.done){
return Container();
            }
          return  Visibility(
            visible: cartModel.state.cartButtonClicked,
            child: Positioned(
                top: 4.0,
                left: 0,
                right:0,
                bottom: height*(2/3),

                child: CartUi()),
          );



          },
        ),










//        Visibility(
//         visible: cartModel.state.cartButtonClicked,
//         child:
//          Positioned(
//              top: 4.0,
//              left: 0,
//              right:0,
//              bottom: height*(2/3),
//
//              child: CartUi()),
//
//       ),




        Scaffold(
        appBar:AppBar(
actions: <Widget>[
  Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      height: 150.0, 
      width: 30.0,
      child: GestureDetector(
        onTap: () {
           cartModel.setState((state)=>
                state.openCart(),
                  catchError: true
                );
        },
        child: Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){

                Navigator.of(context).push(

                  MaterialPageRoute(builder: (context)=>CartUi())
                );
                cartModel.setState((state)=>
                state.openCart(),
                  catchError: true
                );
              },
            ),
            Positioned(
              
              top: 3.0,
              right: 4.0,
              child: Builder(
                
                builder:(_){
                    if(cartModel.connectionState==ConnectionState.waiting){
        return Center(child: CircularProgressIndicator());

      }
      if(cartModel.connectionState==ConnectionState.none){
      return Center(child: Text("00" ,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,

          style: TextStyle(color: Colors.black ,fontWeight: FontWeight.bold)
      )
      );
      }
      
      
      return Center(
        child: Text("${cartModel.state.length}" ,style: TextStyle(color: Colors.black ,fontWeight: FontWeight.bold)
         ),
      );

    }
              ),
              
            )
            
          ],
        ),
      ),
    ),
    
  ),

],
          title: Text("Shopping"),
        ) ,
drawer: Drawer(
  child: Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          currentAccountPicture: Image.network(user_image),
          accountName: Text(name), accountEmail: Text(email),

        ) ,
        Divider(),
        Logout() ,
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InvoiceWidget())

            );

          },
          child: Text("my invoices" ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
        )
      ],
  ),
),
body:

FutureBuilder<List<Products>>(

 future: productModel.getProducts(),
 builder: (context ,snapshot){

   if(snapshot.hasData){
       return GridView.count(crossAxisCount: 2,
         children: snapshot.data.map((product)=>ProductUi(product)).toList(),

       );
   }
   return GFLoader(
       type: GFLoaderType.ios,
       size: GFSize.LARGE,
   );
 },
)








      ),]
    );
  }
}

