import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomListTile extends StatefulWidget {
  final String avatar;
  final String title;

  const CustomListTile({
    Key key,
    @required this.avatar,
    @required this.title,
  }) : super(key: key);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Center(
        child: GestureDetector(
          onTap: (){
            Modular.to.pushNamed("/user-details", arguments: this.widget.title);
          },
          child: ListTile(
            leading: ClipOval(
              child: Image.network(this.widget.avatar),
            ),
            title: Text(this.widget.title, style: TextStyle(
              color: Colors.black
            ),),
            /*trailing: IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.star,
                  color: Colors.black,
                  size: 30,
                )
            ),*/
          ),
        ),
      ),
    );
  }
}


