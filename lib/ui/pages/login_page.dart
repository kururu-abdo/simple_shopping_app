import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myredux/service/interfaces/authentication_service.dart';


import 'package:states_rebuilder/states_rebuilder.dart';
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
class Login extends StatefulWidget{
  static const String id="login";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }


}

class _LoginState  extends State<Login>{
  GoogleSignInAccount _currentUser;
  String _contactText;


  @override
  void initState() {



    super.initState();


    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
    });
    _googleSignIn.signInSilently();


  }

  Future<void> _handleGetContact() async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }
  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

    Future<void> _handleSignOut() => _googleSignIn.disconnect();


  @override
  Widget build(BuildContext context) {
final   facebook =Injector.get<AuthenticationServices>().facebookLogin;
final   google =Injector.get<AuthenticationServices>().googleLogIn;
final   model =Injector.get<AuthenticationServices>();
final formKey =GlobalKey<FormState>();
TextEditingController _nameController = new TextEditingController();
TextEditingController _passwordController = new TextEditingController();



return Scaffold(
drawer: Drawer(),
      body: Container(
        decoration: BoxDecoration(

          image: DecorationImage(
            image: AssetImage(
              "assets/images/login.jpg"

            ),
            fit: BoxFit.cover
          )
        ),
        child: Stack(

           fit: StackFit.expand,

                children: <Widget>[

                  Positioned(
                    top: 30.0,
                    left: 0,
                    right: 0,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back ,color: Colors.white,),
                          onPressed: (){

                          },
                        ),
                        Text("Log In", style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold ,color: Colors.white),) ,


                        Row(
                          children: <Widget>[
                            IconButton(
                               icon: Icon(Icons.menu,color: Colors.white),
                          onPressed: (){
                         Scaffold.of(context).openDrawer();
                          },
                            )

                          ],
                        )
                      ],



                    ),
                  ),
                AnimatedPositioned(
                  left: 30,
                  right:30,
                  top: 120,

                  child:Container(
                    width: double.infinity,
                    height: 300,


                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                   TextFormField(
                     validator: (str)=>str.length==0?"you cannot let this filed empty":null,
                     controller: _nameController,
                     style:TextStyle(color: Colors.white),
                     decoration: InputDecoration(
enabledBorder: OutlineInputBorder
  (
  borderSide: BorderSide(color: Colors.white)
),
                       hintText: "User Name..." ,
hintStyle: TextStyle(color: Colors.white) ,
                       labelText: "name"
                     ),
onSaved: (String str){
     _nameController.text=str;
},
//onChanged: (String str){
//
//                       _nameController.text=str;
//
//},
                   ),
                    TextFormField(
                      controller: _passwordController,
 validator: (str)=>str.length==0?"you cannot let this filed empty":null,
 style:TextStyle(color: Colors.white),
                      obscureText: true,
                        decoration: InputDecoration(
enabledBorder: OutlineInputBorder
  (
  borderSide: BorderSide(color: Colors.white)
),

                       hintText: "Password...",
                          labelText: "password",
                          hintStyle: TextStyle(color: Colors.white)
                     ),
onSaved: (String str){
          _passwordController.text=str;
},
//onChanged: (String str){
//
//         _passwordController.text=str;
//
//
//},
                    ),
                    MaterialButton(
                      child: Text("Log In",style: TextStyle(color: Colors.black),),
                      color: Colors.grey,
                      onPressed: ()async  {

var form = formKey.currentState;
form.save();
if(form.validate()){
    model.webSignIn(context, _nameController.text, _passwordController.text);
}



                      },),

                        ],

                      ),
                    ),
                  ) ,
                  duration: Duration(seconds: 3),
                )

                ,

                  Positioned(
                    left: 0,
                    right: 0,
                    top: 420,
                    child:Center(child: Text("or" ,style: TextStyle(fontSize:25,color: Colors.white ,fontWeight: FontWeight.bold),)),

                  ) ,
                Positioned(
                    left: 0,
                    right: 0,
                    top: 450,
                    child:Divider(
                      color: Colors.white,
                      height: 5.0,
                    ),

                  ) ,
                     Positioned(
                    left: 0,
                    right: 0,
                    top: 470,
                    child:Column(
                      children: <Widget>[
                      SignInButton(
  Buttons.Facebook,
  text: "Sign up with Facebook",
  onPressed: () {
    model.facebookSinIn(context);
  },
),

// with custom text
SignInButton(
  Buttons.Google,
  text: "Sign up with Google",

  onPressed: () {
model.googleSignIn(context);
},

)
])
                        )
                      ],

                    ),
      ),

                ) ;


  }


}