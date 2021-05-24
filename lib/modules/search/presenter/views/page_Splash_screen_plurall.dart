import 'package:flutter/material.dart';

class PageSplashScreenPlurall extends StatefulWidget {
  const PageSplashScreenPlurall({Key key}) : super(key: key);

  @override
  _PageSplashScreenPlurallState createState() => _PageSplashScreenPlurallState();
}

class _PageSplashScreenPlurallState extends State<PageSplashScreenPlurall> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.pushReplacementNamed(context, '/SearchPage/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("imagens/logo_plurall.png", width: 300.0, height: 300.0,),
      ),
    );
  }
}