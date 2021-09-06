import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/states/state.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/user_search_store.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends ModularState<UserDetails, UserSearchStore> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Observer(builder: (_){
      return Visibility(
        visible: controller.showUserDetails,
        child: Container(
          width: _size.width,
          height: _size.height,
          color: Colors.black38,
          child: Center(
            child: Container(
              width: _size.width - 64,
              height: _size.height - 250,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              padding: EdgeInsets.only(left: 16, right: 16),
              child: StreamBuilder(
                builder: (context, snapshot){
                  final state = controller.state;
                  if (state is UserSearchStart) {
                    return Center(child: CircularProgressIndicator(),);
                  } else if (state is UserSearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is UserSearchSuccess) {
                    final user = (state).userSearch;
                    return Stack(
                      children: [
                        Positioned(
                            top: 16,
                            right: 0,
                            child: IconButton(
                              onPressed: controller.showDetails,
                              icon: Icon(Icons.close, size: 30,),
                            )
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Image.asset(user.avatar,
                                  width: 130,
                                  height: 130,
                                ),
                              ),
                              SizedBox(height: 16,),
                              Text(user.login,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: "Raleway-Bold"
                                ),
                              ),
                              SizedBox(height: 16,),
                              Text(user.name,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: "Raleway-Bold"
                                ),
                              ),
                              SizedBox(height: 16,),
                              Text(user.location ?? "",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Raleway"
                                ),
                              ),
                              SizedBox(height: 16,),
                              Text(user.email,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Raleway"
                                ),
                              ),
                              SizedBox(height: 16,),
                              Text(user.bio,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Raleway"
                                ),
                              ),
                              SizedBox(height: 30,),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.green
                                    ),
                                  ),
                                  onPressed: (){},
                                  child: Text("Favoritar",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
