import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/authentication/signup_screen.dart';


import '../global/global.dart';
import '../splash_screen/splash_screen.dart';
import '../widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController =TextEditingController() ;
  TextEditingController passwordTextEditingController =TextEditingController() ;

  validateForm() {
    if (emailTextEditingController.text.isEmpty ||
        !RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailTextEditingController.text)) {
      Fluttertoast.showToast(msg: "Email non valide ");
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password ne doit pas etre vide.");
    } else {
      LoginUserNow();
    }
}
  LoginUserNow() async {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c){
          return ProgressDialog(message: "Chargement ....",);
        });
    final User? firebaseUser= (
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error:"+msg.toString());
        })
    ).user;
    if(firebaseUser != null){
      DatabaseReference driverRef = FirebaseDatabase.instance.ref().child("users");
      driverRef.child(firebaseUser.uid).once().then((driverKey)
      {
        final snap =driverKey.snapshot;
        if(snap.value !=null){
          currentFirebaseUser =firebaseUser;
          Fluttertoast.showToast(msg: "Authentification reussie");
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }else
        {
          Fluttertoast.showToast(msg: "Pas d'enregistrement avec cet email.");
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
      });
    }
    else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Erreur pendant l'authentification");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:  Image.asset("images/logo2.png"),
              ),
              const SizedBox(height: 10,),
              const Text(
                "S'Authentifier comme Utilisateur",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
                ),
              ),
              TextField (
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Entrer votre email",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),

                  )
              ),
              TextField(
                  controller: passwordTextEditingController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Password",
                    hintText: "Entrer votre password",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),

                  )
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreenAccent,
                ),
                child: const Text(
                  "Se connecter",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUpScreen()));
                  },
                  child:const Text(
                    "Creer un compte",
                    style: TextStyle(
                      color: (Colors.grey),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
