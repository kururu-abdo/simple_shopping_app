import 'package:flutter/material.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/getflutter.dart';
import 'package:myredux/domain/entities/invoice.dart';
import 'package:myredux/service/interfaces/invoice_services.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class InvoiceWidget extends StatelessWidget{
final bool isCkeced =false;

  @override
  Widget build(BuildContext context) {
var productModel = Injector.getAsReactive<InvoiceService>(context: context);

    return Scaffold(
      appBar: AppBar(

        title: Text("my invoices"),

      ),
      body: Material(
        elevation: 6.0,
        child:Builder(builder: (context){
          if(productModel.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          if(productModel.connectionState==ConnectionState.none){
            return Container();
          }

          return FutureBuilder<List<Invoic>>(
            future: productModel.state.getAllInvoices(),
            builder: (context,snapshot){
              if(!snapshot.hasData){
                return GFLoader(
                  type: GFLoaderType.ios,
                  size: 50,
                );
              }
              return    ListView(
                children: snapshot.data.map((invoice){
                  return ListTile(
                    title: Text("Date:   ${invoice.date}"),
                    subtitle: Text("total amount:  ${invoice.price}"),
                    trailing: Checkbox(
                      onChanged: (bool value) {
                        productModel.setState((state)=>
                        state.payInvoice(invoice),
                          catchError: true
                        );
                      },
                      value: isCkeced,

                    ),

                  );
                }).toList(),
              );
            },



          );

        },),
      ),
    );
  }








}