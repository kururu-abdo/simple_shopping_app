import 'package:myredux/domain/exceptions/web_user_exception.dart';

class WebUser{
String  password;
  String user;
  String userName;


  WebUser(this.password,this.user ,this.userName);

  WebUser.fromJson(Map<String, dynamic > data){
    password= data['password'];
    user=data['user'];
    userName=data['fullName'];
  }
Map<String , dynamic>  toJson(){
    _validation();
    return {
      'password': password,
      'user':user,
      'fullName':userName
    };
}



 _validation(){
    if(userName==null){
      WebUserException("اسم المستخدم مطلوب");
    }
     if(password==null){
      WebUserException("كلمة السر مطلوبة");
    }
  }
}