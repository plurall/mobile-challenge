import 'package:flutter/material.dart';

class PageSplashScreen extends StatefulWidget {
  const PageSplashScreen({Key key}) : super(key: key);

  @override
  _PageSplashScreenState createState() => _PageSplashScreenState();
}

class _PageSplashScreenState extends State<PageSplashScreen> {
  
  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.pushReplacementNamed(context, '/PageSplashScreenPlurall');
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("imagens/logo_somos_educacao.png", width: 300.0, height: 300.0,),
     ),
    );
  }
}
