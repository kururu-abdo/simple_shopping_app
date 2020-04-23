import 'package:myredux/ui/exceptions/ui_exceptions.dart';

class ErrorHandler{
 static String errorMessage(dynamic error) {
   if(error == null){
     return null;
   }
   if(error is NetworkException){
     return error.msg;
   }

if(error is WrongCredentialsException){
     return error.msg;
   }

if(error is ProductNotFoundException){
     return error.msg;
   }



 }


}