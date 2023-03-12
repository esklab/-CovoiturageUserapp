import 'dart:async';
import 'package:flutter/material.dart';

import '../assistants/assistants_methods.dart';
import '../authentication/login_screen.dart';
import '../global/global.dart';
import '../maiScreen/main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer()
   {
    fAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo():null;
    Timer(const Duration(seconds: 3),()async {
      //Navigator.push(context, MaterialPageRoute(builder: (c) => const MainScreen()));
      if(await fAuth.currentUser != null){
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c) => const LoginScreen()));
      }
     });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo2.png"),
              const SizedBox(height: 10.0,),
              const Text(
                "Carpool App",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
