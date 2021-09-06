import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/user_search_store.dart';

class CustomListTile extends StatefulWidget {
  final String avatar;
  final String title;

  const CustomListTile({
    Key key,
    @required this.avatar,
    @required this.title
  }) : super(key: key);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends ModularState<CustomListTile, UserSearchStore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Center(
        child: GestureDetector(
          onTap: () async {
            controller.setSearchText(this.widget.title);
            controller.showDetails();
          },
          child: ListTile(
            leading: ClipOval(
              child: Image.network(this.widget.avatar),
            ),
            title: Text(this.widget.title),
            trailing: IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.star_border_rounded,
                  color: Colors.black,
                  size: 30,
                )
            ),
          ),
        ),
      ),
    );
  }
}

