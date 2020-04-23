import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myredux/main.dart';
import 'package:myredux/service/interfaces/shared_pref_services.dart';
import 'package:myredux/ui/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPrefServices sharedPrefServices = new SharedPrefServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: CircularProgressIndicator(),
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 5), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }



  void navigateUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool(ISLOGGEDIN) ?? false;
    print(status);
    if (status) {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>HomePage()));
    } else {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>Login()));
    }
  }
}