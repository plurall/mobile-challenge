import 'package:flutter/material.dart';

///------------------------------ Funções gerais -------------------------------
//Função generica para calcular o tamanho da tela
mediaQuery(BuildContext context, double value, {String direction}) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  direction = direction ?? 'H';
  Size size = mediaQuery.size;
  if (direction.toUpperCase() == 'H') {
    return size.width * value;
  } else {
    return size.height * value;
  }
}
