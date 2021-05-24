import 'package:flutter/material.dart';
import 'package:mobile_challenge/modules/search/presenter/widgets/custom_appbar.dart';


class PagePerfil extends StatefulWidget {
  const PagePerfil({Key key}) : super(key: key);

  @override
  _PagePerfilState createState() => _PagePerfilState();
}

class _PagePerfilState extends State<PagePerfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      body: Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text("Somente para exibição"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
