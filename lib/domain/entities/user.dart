import 'package:myredux/domain/exceptions/web_user_exception.dart';

class UserModel{
  int id;
  String name;
  String password;
  UserModel(this.id,this.name ,this.password);



  UserModel.fromJson(Map<String , dynamic> json){
    id =json['id'];
    name=json['name'];
    password= json['password'];
  }


  Map<String ,dynamic> toJson(){
    _validation();
    return {
      'id':id,
      'name':name,
      'password':password
    };
  }

  _validation(){
    if(name==null){
      WebUserException("اسم المستخدم مطلوب");
    }
     if(password==null){
      WebUserException("كلمة السر مطلوبة");
    }
  }
}