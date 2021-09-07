import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  AnimationController animation;
  Animation<double> _fadeInFadeOut;

  splashScreenPage() async {
    Future.delayed(Duration(milliseconds: 2500))
        .whenComplete(() => Modular.to.pushReplacementNamed("/home"));
  }

  @override
  void initState() {
    splashScreenPage();
    animationController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          color: Colors.white,
          child: FadeTransition(
            opacity: _fadeInFadeOut,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 120, maxHeight: 120),
                    child: Image.asset("assets/images/icon-splash.png")
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text("Mobile Challenge",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontFamily: "Raleway",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  animationController() {
    animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );
    _fadeInFadeOut = Tween<double>(begin: 1, end: 0.0).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }
}
