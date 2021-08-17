import 'package:flutter/material.dart';
class ProfileBio extends StatelessWidget {
  String login;
  String name;
  String email;
  String bio;
  String location;

  ProfileBio(this.login,this.name,this.email,this.bio,this.location);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Stack(children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(2, 0.1, 1, 1),
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(style: BorderStyle.solid, width: 0.40),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          color: Colors.green,
                          icon: new Icon(
                            Icons.account_box_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(child: Text(this.login))
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        IconButton(
                          color: Colors.green,
                          icon: new Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(child: Text(this.name))
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        IconButton(
                          color: Colors.green,
                          icon: new Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(child: Text(this.email))
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        IconButton(
                          color: Colors.green,
                          icon: new Icon(
                            Icons.paste,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(child: Text(this.bio))
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        IconButton(
                          color: Colors.green,
                          icon: new Icon(
                            Icons.place,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(child: Text(this.location))
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ]),
    );
  }
}
