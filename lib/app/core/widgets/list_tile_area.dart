import 'package:flutter/material.dart';

class ListTileArea extends StatelessWidget {

  final Widget child;

  const ListTileArea({
    Key key,
    @required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            height: 100,
            child: this.child,
          ),
        ));
  }
}
