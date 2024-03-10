

import 'dart:convert';
import 'dart:typed_data';

import 'package:cash_back/ScannerScreen.dart';
import 'package:cash_back/shared/colors.dart';
import 'package:cash_back/shared/network/local/cash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Product.dart';

class ScanStepScreen extends StatefulWidget {
  const ScanStepScreen({Key? key}) : super(key: key);

  @override
  State<ScanStepScreen> createState() => _ScanStepScreenState();
}
class _ScanStepScreenState extends State<ScanStepScreen> {
  List<String> productName = [];
  List<String> qrCode = [];
  List<String> montant = [];
  @override
  Widget build(BuildContext context) {
    setState(() {
      CashHelper.getData(key: "productRem").then((value) {
        if (value != null) {
          setState(() {
            productName = value;
          });
        }
      });
    });

    CashHelper.getData(key: "montant").then((value) {
      if (value != null) {
        setState(() {
          montant = value;
        });
      }
    });
    CashHelper.getData(key: "qrCode").then((value) {
      if (value != null) {
        setState(() {
          qrCode = value;
        });
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: productName.length == 0 ?
         Center(child: Text('No Product Added Yet',
           style: TextStyle(
             color: Colors.black,
               fontSize: 20,
               fontWeight: FontWeight.bold
           ),
         )):

       ListView.separated(
         primary: false,
         shrinkWrap: true,
         scrollDirection: Axis.vertical,
         itemCount: productName.length,
         itemBuilder: (BuildContext context, int index) {
           return      Container(
               padding: EdgeInsets.all(10),
               width: double.infinity,
               height: 100,
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                   color: Colors.grey[200]
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text('${index+1}',
                         style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold
                         ),
                       ),
                       SizedBox(width: 20,),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('${productName[index]}',
                             style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold
                             ),
                           ),
                           SizedBox(height: 20,),
                           Text('${qrCode[index]}',
                             style: TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.bold
                             ),
                           ),
                         ],
                       ),
                       Spacer(),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           IconButton(onPressed: (){
                              setState(() {
                                productName.removeAt(index);
                                qrCode.removeAt(index);
                                montant.removeAt(index);
                                CashHelper.putData(key: "productRem", value: productName);
                                CashHelper.putData(key: "qrCode", value: qrCode);
                                CashHelper.putData(key: "montant", value: montant);
                              });
                           }, icon: Icon(Icons.cancel,color: Colors.red,)),
                           Row(
                             children: [
                               Text('Price : ',style: TextStyle(color: Colors.black),),
                               Text('${montant[index]} TND',style: TextStyle(color: Colors.black),),
                             ],
                           )
                         ],
                       ),


                     ],
                   ),

                 ],
               )
           );
         },
         separatorBuilder: (BuildContext context, int index) {return SizedBox(height: 20,);},),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contex) =>  MyScannerScreen()
              ));
        },
        backgroundColor: mainColor,
        child: const Icon(Icons.qr_code_scanner_outlined),
      ),
    );
  }

}
