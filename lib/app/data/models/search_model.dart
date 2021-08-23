class SearchModel {
  SearchModel({
    this.login,
    this.avatarUrl,
  });

  String login;
  String avatarUrl;

  SearchModel.fromJson(Map<String, dynamic> json) {
    this.login = json['login'];
    this.avatarUrl = json['avatar_url'];
  }

  static List<SearchModel> fromJsonList(List jsonList) =>
      jsonList?.map((e) => SearchModel.fromJson(e))?.toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['avatar_url'] = this.avatarUrl;
    return data;
  }
}
