import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/login/signin.dart';
import 'package:todo_app/pages/home.dart';




class SplashService{
  
  void isLogin(BuildContext context){
       final  auth = FirebaseAuth.instance;
       final user = auth.currentUser;

       if(user!=null){
        Timer(const Duration(seconds: 2),
              ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()))
      );
       }else{
        Timer(const Duration(seconds: 2),
              ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()))
      );
       }
  }
}