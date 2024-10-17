import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginpage.dart';



class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => Loginpage()));
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/Binder Cover Freebies.jpeg',
              height: 300,
              width: 300,
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator()
          
          ],
        ),
      ),
    );
  }
}
