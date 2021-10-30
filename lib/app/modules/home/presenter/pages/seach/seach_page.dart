import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/modules/home/external/datasource/home_request_data.dart';
import 'package:mobile_challenge/app/modules/home/presenter/widgets/card_users_widget.dart';
import 'package:mobile_challenge/app/shared/domain/Entities/user_model.dart';
import '../home/home_controller.dart';

class SeachPage extends StatefulWidget {

  @override
  _SeachPageState createState() => _SeachPageState();
}

class _SeachPageState extends State<SeachPage> {
  HomeController _controller = HomeController(homeService: HomeService());
  List<Users> _allUsers = [];
  List<Users> _filtroUsers = [];
  @override
  void initState() {
    super.initState();
    getDados();
  }
  getDados() async {
    _allUsers = await _controller.getUsersSeach();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[350],
            borderRadius: BorderRadius.circular(12)
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            color: Colors.white,
            child: TextField(
              autofocus: true,
              onChanged: (value) => onSearchTextChanged(value),
              decoration: const InputDecoration(
                labelText: 'Pesquisar Users', 
                suffixIcon: Icon(Icons.search),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(20)
              ),
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _filtroUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: _filtroUsers.length,
                    itemBuilder: (context, index) {
                      return CardUsersWidget(model: _filtroUsers[index]);
                    }
                  )
                : const Center(
                  child: Text(
                      'Sem resultados',
                      style: TextStyle(fontSize: 24),
                    ),
                ),
            ),
          ],
        ),
      ),
    );
  }


  onSearchTextChanged(String text) async {
    List<Users> results = [];
    if (text.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers.where((user) =>
        user.login.toLowerCase().contains(text.toLowerCase())).toList();
    }
    setState(() {
      _filtroUsers = results;
    });
  }
}