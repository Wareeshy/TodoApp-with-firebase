import 'package:flutter/material.dart';
import 'package:todo_app/Splash/splash_service.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splash = SplashService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const  EdgeInsets.symmetric(horizontal: 30.0),
            child: Center(child: Image.asset('images/splash.png')),
          ),
          Text(
            'TODO APP',
            style: TextStyle(
                fontSize: 30.0,
                color: Color(0xff2e8b6d),
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
