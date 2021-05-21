import 'package:flutter/material.dart';

class GenericErrorDisplay extends StatelessWidget {
  const GenericErrorDisplay({
    Key key,
    this.onTryAgain,
  }) : super(key: key);
  final Function onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Infelizmente algum erro ocorreu :(',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Precione o botão "Tentar novamente" para recarregar',
            style: TextStyle(
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blue[700]),
            ),
            onPressed: onTryAgain,
            child: Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}
