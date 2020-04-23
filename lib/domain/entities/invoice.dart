class Invoic{
  int id;

  String date;
  double price;
  int isPaid;
  Invoic(this.price ,[this.date,this.id ,this.isPaid] ){

    isPaid=0;
    date=DateTime.now().toIso8601String();
  }


  Invoic.fromJson(Map<String ,dynamic> json){
    id=json['id'];

    date=json['date'];
    price=json['price'];
    isPaid=json['ispaid'];
  }


  Map<String  ,dynamic> toJson(){
    return {
      'id':id,

      'date': date,

      'price':price,
      'ispaid':isPaid
    };
  }
}