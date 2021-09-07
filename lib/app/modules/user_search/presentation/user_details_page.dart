import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/states/state.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/user_search_store.dart';
import 'package:localstore/localstore.dart';

class UserDetails extends StatefulWidget {
  final ModularArguments login;
  const UserDetails({
    Key key,
    this.login
  }) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends ModularState<UserDetails, UserSearchStore> {

  final db = Localstore.instance;

  _getUser(){
    controller.setSearchText(this.widget.login.data);
    controller.isFavVerification(this.widget.login.data);
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Material(
      child: Observer(builder: (_){
        Widget content;
        final state = controller.state;
        if (state is UserSearchStart) {
          content = SizedBox();
        } else if (state is UserSearchLoading) {
          content = Center(child: CircularProgressIndicator(color: Colors.black,));
        } else if(state is UserSearchError){
          content = Center(
            child: Text("Algo deu errado :( \n"
                "Tente de novo mais tarde.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Raleway"
              ),
            ),
          );
        } else if (state is UserSearchSuccess) {
          var user = (state).userSearch;
          content = SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(     // Replace this child with your own
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: ClipOval(
                    child: Image.network(
                      user.avatar,
                      height: 120,
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Visibility(
                  visible: user.name != null,
                  child: Text(user.name ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: "Raleway-Bold"
                    ),
                  ),
                ),
                Text(user.login,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Raleway-Bold"
                  ),
                ),
                SizedBox(height: 16,),
                Visibility(
                  visible: user.location != null,
                  child: Column(
                    children: [
                      Text(user.location ?? "",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Raleway"
                        ),
                      ),
                      SizedBox(height: 16,),
                    ],
                  ),
                ),
                Visibility(
                  visible: user.email != null,
                    child: Column(
                      children: [
                        Text(user.email ?? "",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Raleway"
                          ),
                        ),
                        SizedBox(height: 16,),
                      ],
                    )
                ),
                Visibility(
                    visible: user.bio != null,
                    child: Column(
                      children: [
                        Text(user.bio ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Raleway"
                          ),
                        ),
                        SizedBox(height: 30,),
                      ],
                    )
                ),
                controller.isFavorite == false ? ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.green
                      ),
                    ),
                    onPressed: (){
                      setState(() {
                        controller.saveUser(user);
                        controller.isFavVerification(user.login);
                      });
                    },
                    child: Text("Favoritar",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                )
                    : Icon(Icons.star, size: 40, color: Colors.green,)
              ],
            ),
          );
        } else {
          content = SizedBox();
        }

        return Container(
          width: _size.width,
          height: _size.height,
          color: Colors.black38,
          child: Center(
            child: Container(
              width: _size.width - 64,
              height: _size.height - 280,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Stack(
                children: [
                  Positioned(
                      top: 16,
                      right: 0,
                      child: IconButton(
                        onPressed: (){
                          Modular.to.pop();
                        },
                        icon: Icon(Icons.close, size: 30,),
                      )
                  ),
                  Center(
                    child: content,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
