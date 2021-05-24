import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Mensagens {

  mensagemFavoritos (){
    Fluttertoast.showToast(
        msg: "Adicionado aos favoritos",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 20.0
    );
  }

  mensagemDeletadoFavorito (){
    Fluttertoast.showToast(
        msg: "Favorito deletado de sua lista!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 20.0
    );
  }

  mensagemExibicao (){
    Fluttertoast.showToast(
        msg: "Colocado apenas para exibição",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 20.0
    );
  }

}
