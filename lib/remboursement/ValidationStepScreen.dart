import 'dart:io';

import 'package:cash_back/remboursement/ScanStepScreen.dart';
import 'package:cash_back/shared/colors.dart';
import 'package:flutter/material.dart';

import '../shared/network/local/cash_helper.dart';

class ValidationStepScreen extends StatefulWidget {
  const ValidationStepScreen({Key? key}) : super(key: key);

  @override
  State<ValidationStepScreen> createState() => _ValidationStepScreenState();
}

class _ValidationStepScreenState extends State<ValidationStepScreen> {
  List<String> productName = [];
  List<String> qrCode = [];
  List<String> montant = [];
  File? _imageFile;
  @override
  Widget build(BuildContext context) {
    CashHelper.getDataString(key: "image").then((value) {
      setState(() {
        _imageFile = File(value!);
      });
      CashHelper.getData(key: "productRem").then((value) {
        setState(() {
          productName = value!;
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
        setState(() {
          qrCode = value!;
        });

      });

    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,

        children: [
          Column(
            children: [
              Flexible(
                child: Container(
                  width: 200,
                  height: 200,


                  decoration: BoxDecoration(
                    border: Border.all(
                        color: mainColor,
                        width: 3
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black12,),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                    ),
                  ),


                ),
              ),
            ],
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 220,
            child: ListView.separated(
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
                            Row(
                              children: [
                                Text('Price : ',style: TextStyle(color: Colors.black),),
                                Text('${montant[index]} TND',style: TextStyle(color: Colors.black),),
                              ],
                            )


                          ],
                        ),

                      ],
                    )
                );
              },
              separatorBuilder: (BuildContext context, int index) {return SizedBox(height: 20,);},),
          ),

        ],
      ),
    );
  }
}
