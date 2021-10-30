import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/modules/home/presenter/pages/detalhes/detalhes_page.dart';
import 'package:mobile_challenge/app/shared/domain/Entities/user_model.dart';

class CardUsersWidget extends StatelessWidget {
  final Users model;

  CardUsersWidget({
    @required this.model
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => DetalhesPage(model))
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Hero(
                    tag: model.login,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(model.avatarUrl),
                      radius: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(model.login),
                ],
              ),

              IconButton(
                onPressed: (){}, 
                icon: Icon(Icons.info_outline)
              )
            ],
          ),
        ),
      ),
    );
  }
}