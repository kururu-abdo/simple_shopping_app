import 'package:flutter/material.dart';
import 'package:myredux/service/interfaces/shared_pref_services.dart';
import 'package:myredux/ui/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Logout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var pref =Injector.get<SharedPrefServices>();

    return   MaterialButton(
      onPressed: (){

        logoutUser(context,pref);
      },
      child: Row(children: <Widget>[
        Text("logout"),
        Icon(Icons.exit_to_app)
      ],),

    );
  }


  void logoutUser(BuildContext context ,prefs) async{
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs?.clear() ;
 Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
     ModalRoute.withName("/home")
    );
}

}