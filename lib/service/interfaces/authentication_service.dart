import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myredux/domain/entities/web_user_login.dart';
import 'package:myredux/domain/exceptions/web_user_exception.dart';
import 'package:myredux/main.dart';
import 'package:myredux/service/interfaces/i_api.dart';
import 'package:myredux/service/interfaces/shared_pref_services.dart';
import 'package:myredux/ui/exceptions/ui_exceptions.dart';
import 'package:myredux/ui/pages/login_page.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert' as JSON ;

import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
 class AuthenticationServices{
  final FacebookLogin _facebookLogin =new FacebookLogin();
  FacebookLogin get facebookLogin=>_facebookLogin;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _db = Firestore.instance;
    GoogleSignInAccount _currentUser;
    IApi _api;
PublishSubject isLoding =PublishSubject();
SharedPrefServices pref = new SharedPrefServices();
AuthenticationServices(this._api );
  final GoogleSignIn _googleSignIn =new GoogleSignIn(
   scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],

  );

GoogleSignIn get googleLogIn =>_googleSignIn;
PublishSubject  isLoading=PublishSubject();

Observable<Map<String ,dynamic>>  userProfile;



webLogin(String name ,String password)async{
  isLoading.add(true);
 return await _api.userLogin(name, password);
}
webSignIn(context ,String name , password) async{
  isLoading.add(true);
  try{
      final  login = await http.get("http://localhost:5544/users?name=$name&password=$password");
       Map<dynamic ,dynamic> result=JSON.jsonDecode(login.body);
      UserLogin user = UserLogin.fromJson(result);
      if(user.user.name!=null) {
        await pref.saveUser(
            context, user.user.name, user.user.email, user.user.pic);
        isLoading.add(false);
      } else{
        throw WebUserException("check  email or password");
      }

  }catch(e){
    throw NetworkException("مشكلة في الشبكة");
  }

}
googleSignIn(context) async{
  isLoading.add(true);
try {
    await _googleSignIn.signIn();
    GoogleSignInAccount account= await _googleSignIn.signIn();

GoogleSignInAuthentication auth =  await account.authentication;

var doc_ic=await _db.document("users").documentID;
print(doc_ic);
var info = await _db.collection('user');





           await pref.saveUser(context,googleLogIn.currentUser.displayName,googleLogIn.currentUser.email??"" ,googleLogIn.currentUser.photoUrl);

print(googleLogIn.currentUser.email);
print(googleLogIn.currentUser.displayName);
  } catch (error) {

  }
}
facebookSinIn(context) async{
  isLoading.add(true);
 final FacebookLoginResult result =
        await _facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        var token = accessToken.token;
        final  graphResponse = await http.get("https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}");
        Map<dynamic ,dynamic> profile=JSON.jsonDecode(graphResponse.body);
        print(profile);
       await pref.saveUser(context,profile['name'] ,profile['email']??"" ,profile['picture']['data']['url']);


        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:

        break;
    }
}
facebookSignOut() async{
 await _facebookLogin.logOut();
}

googleSignOut() async{

await googleLogIn.signOut();


}








}

//final Auth authServices =Auth();