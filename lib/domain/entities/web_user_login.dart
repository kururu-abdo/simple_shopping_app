class UserLogin {
  MyUser user;

  UserLogin({this.user});

  UserLogin.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new MyUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class MyUser {
  String name;
  String password;
  String fullName;
  String email;
  String pic;

  MyUser({this.name, this.password, this.fullName, this.email, this.pic});

  MyUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password = json['password'];
    fullName = json['fullName'];
    email = json['email'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password'] = this.password;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['pic'] = this.pic;
    return data;
  }
}
