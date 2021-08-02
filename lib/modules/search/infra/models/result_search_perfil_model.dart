import 'dart:convert';
import 'package:mobile_challenge/modules/search/domain/entities/result_search_perfil.dart';

class ResultSearchPerfilModel extends ResultSearchPerfil{
  final String name;
  final String email;
  final String avatar_url;
  final String bio;
  final String location;

  ResultSearchPerfilModel({this.name, this.email, this.avatar_url,this.bio,this.location});

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'avatar_url':avatar_url,
      'bio':bio,
      'location':location
    };
  }

  static ResultSearchPerfilModel fromMap(Map<String,dynamic> map){
    if(map==null) return null;

    return ResultSearchPerfilModel(
      name:map['name'],
      email:map['email'],
      avatar_url:map['avatar_url'],
      bio:map['bio'],
      location:map['location'],

    );
  }

  String toJson() => json.encode(toMap());
  static ResultSearchPerfilModel fromJson(String source) => fromMap(json.decode(source));

}