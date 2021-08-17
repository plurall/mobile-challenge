import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Center(child: Text(' S O B R E           ',style: TextStyle(color: Colors.black54),),),
        backgroundColor: Colors.amberAccent,
        leading: Container(),
      ),
      body:Container(
          color: Colors.white,
          child:
          Column(
            children: [
              Center(
                child: Image.asset('assets/images/logo.png',height: 320,),
              ),
              Text("Aplicativo modelo desenvolvido\n         "
                  "   para fins didáticos\n ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black45),)
            ],
          )
      ),
    );
  }
}
