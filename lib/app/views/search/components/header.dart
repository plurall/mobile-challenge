import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final double height;
  final TextEditingController controller;
  final Function(String value) _getSpecificTag;

  Header(this.height,this.controller,this._getSpecificTag);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Center(
            child: Text(
              "GITHUB PESQUISA",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54),
            ),
          ),
          color: Colors.amberAccent,
          height: this.height + 70,
          width: MediaQuery.of(context).size.width,
        ),
        Container(),
        Positioned(
          top: 100.0,
          left: 20.0,
          right: 20.0,
          child: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: FaIcon(FontAwesomeIcons.github,size:35,color: Theme.of(context).primaryColor),
            ),
            primary: false,
            title: TextField(
                controller: this.controller,
                decoration: InputDecoration(
                    hintText: "Informe o usuário  ...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey))),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
                onPressed: () {this._getSpecificTag(this.controller.text);},
              ),
              //  IconButton(icon: Icon(Icons.notifications, color: Theme.of(context).primaryColor),
              //  onPressed: () {},)
            ],
          ),
        )
      ],
    );
  }
}
