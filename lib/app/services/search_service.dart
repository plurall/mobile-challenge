import 'package:mobile_challenge/app/models/search_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SearchService {

  Future<List<SearchModel>> search(String user) async {
    String _url = "https://api.github.com/search/users?q="+user;

    var response = await http.get(_url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final list =(jsonResponse['items'] as List)
          .map((e) => SearchModel.fromMap(e))
          .toList();
      return list;
    }
    return null;
  }
}
