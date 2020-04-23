import 'package:flutter/material.dart';
import 'package:myredux/ui/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

const USER_NAME ="name";
const USER_EMAIL="email";
const  USER_PROFILE ="profile";
const  ISLOGGEDIN ="isLoggedIn";
class SharedPrefServices  {

Future<void> saveUser(context,String name ,[String email=null,String profile=null ,bool isLoggedIn=true]) async{

  SharedPreferences pref =await SharedPreferences.getInstance();
  pref.setString(USER_NAME, name);
   pref.setString(USER_EMAIL, email);
   pref.setString(USER_PROFILE, profile);
   pref.setBool(ISLOGGEDIN, isLoggedIn);
Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
     ModalRoute.withName("/home")
    );

}

Future<SharedPreferences>  getData()async{
  return SharedPreferences.getInstance();
}

Future<void>  logout()async{
  SharedPreferences pref =await SharedPreferences.getInstance();
pref.setBool(ISLOGGEDIN, false);

}


}