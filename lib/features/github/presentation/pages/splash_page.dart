import 'package:flutter/material.dart';
import 'package:mobile_challenge/features/github/presentation/pages/start_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _loading() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => StartPage(),
      ),
    );
  }

  @override
  void initState() {
    _loading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: _size.height,
        width: _size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 500),
              curve: Curves.decelerate,
              builder: (context, value, child) {
                return Positioned(
                  top: _size.height / 2 - 50,
                  child: Image.asset(
                    'assets/icons/logo.png',
                    height: value * 100,
                  ),
                );
              },
            ),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: -1.0, end: 1.0),
              duration: Duration(milliseconds: 500),
              builder: (_, value, child) {
                return Positioned(
                  top: _size.height / 2 + 60,
                  left: value * 100,
                  child: child,
                );
              },
              child: Text(
                'GitHub Challenge',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
