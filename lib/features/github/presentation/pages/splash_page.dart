import 'package:flutter/material.dart';
import 'package:mobile_challenge/core/constants/app_typography.dart';
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
              duration: Duration(milliseconds: 700),
              curve: Curves.decelerate,
              builder: (_, value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/logo.png',
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'GitHub Challenge',
                    style: AppTypography.splashPageTitle(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
