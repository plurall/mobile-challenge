import 'package:flutter/material.dart';
import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';


class ItemSearch extends StatelessWidget {

  ResultSearch resultSearch;
  VoidCallback onTapUsuario;


  ItemSearch({
    @required this.resultSearch,
    this.onTapUsuario,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapUsuario,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(children: <Widget>[

            SizedBox(
              width: 120,
              height: 120,
              child: Image.network(
                resultSearch.image == null ? " " : resultSearch.image,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text(
                    resultSearch.login ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
                ),
              ),
            ),
           ],
          ),
        ),
      ),
    );
  }
}
