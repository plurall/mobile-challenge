class ProfileModel {
  final String name;
  final String email;
  final String avatar_url;
  final String bio;
  final String location;

  ProfileModel({
    this.name, this.email, this.avatar_url,this.bio,this.location
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name:json['name'],
      email:json['email'],
      avatar_url:json['avatar_url'],
      bio:json['bio'],
      location:json['location'],
    );
  }

  static ProfileModel fromMap(Map<String,dynamic> map){
    if(map==null) return null;

    return ProfileModel(
      name:map['name'],
      email:map['email'],
      avatar_url:map['avatar_url'],
      bio:map['bio'],
      location:map['location'],
    );
  }

  Map toMap(){
    Map<String,dynamic> map = {
      'name':this.name,
      'email': this.email,
      'avatar_url': this.avatar_url,
      'bio': this.bio,
      'location': this.location,
    };

    return map;
  }
}