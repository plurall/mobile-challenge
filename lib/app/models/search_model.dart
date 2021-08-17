class SearchModel {
  final String login;
  final int id;
  final String avatar_url;

  SearchModel({
    this.login, this.id, this.avatar_url
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
        login: json['login'],
        id: json['id'],
        avatar_url: json['avatar_url']
    );
  }

  static SearchModel fromMap(Map<String,dynamic> map){
    if(map==null) return null;

    return SearchModel(
      login:map['login'],
      id:map['id'],
      avatar_url:map['avatar_url'],
    );
  }

}