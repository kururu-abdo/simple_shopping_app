import 'package:myredux/dataSources/local_database.dart';
import 'package:myredux/domain/entities/invoice.dart';
import 'package:rxdart/rxdart.dart';


class InvoiceService{
 final DBHelper db;
 InvoiceService(this.db);
 PublishSubject<List<Invoic>> _invoices= new  PublishSubject<List<Invoic>>();
  PublishSubject<List<Invoic>>  get invoices =>  _invoices.stream;
  PublishSubject<Invoic> _invoice= new  PublishSubject<Invoic>();
  PublishSubject<Invoic>  get invoice =>  _invoice.stream;
  bool _isPaid =false;
  bool get isPaid =>_isPaid;
 Future<List<Invoic>> getAllInvoices() async{
   List<Invoic> data = await db.getInvoices();
   print("database:");
   print(data);
   _invoices.sink.add(data);
   return data;

 }
 payInvoice(Invoic invoic) async{
   _isPaid=true;
   await deleteInvoice(invoic.id);


 }



  Future<Invoic> getAllInvoice(int invoiceId) async{
   var data = await db.getInvoice(invoiceId);
   _invoice.sink.add(data);
   return data;

 }

 Future<void>  deleteInvoice(int invoiceId) async{
   return await db.deleteInvoice(invoiceId);
 }
 Future<void>  updateInvoice(Invoic model) async{
   return await db.updateInvoice(model);
 }
  Future<void>  InsertInvoice(Invoic model) async{
   print("going to date base");
    await db.saveInvoice(model);
 }

}