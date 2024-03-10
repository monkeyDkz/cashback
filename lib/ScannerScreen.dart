import 'dart:async';

import 'package:cash_back/shared/network/local/cash_helper.dart';
import 'package:cash_back/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';
import 'package:flutter/material.dart';

import 'models/Product.dart';

class MyScannerScreen extends StatefulWidget {
  @override
  State<MyScannerScreen> createState() => _MyScannerScreenState();
}

class _MyScannerScreenState extends State<MyScannerScreen> {
  String? barcode;
  int test =0 ;

  List<String> productName = [];
  List<String> qrCode = [];
  List<String> id = [];
  List<String> montant = [];
  @override
  void initState() {
    CashHelper.getData(key: "productRem").then((value) {
      if (value != null) {
        setState(() {
          productName = value;
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
    CashHelper.getData(key: "idRem").then((value) {
      if (value != null) {
        setState(() {
          id = value;
        });
      }
    });
    CashHelper.getData(key: "montant").then((value) {
      if (value != null) {
        setState(() {
          montant = value;
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Scan Bar Code ',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: () {
    Navigator.of(context).pop();
          },
        ),
        ),
        body: Column(
          children: [
            Container(
              height: 400,
              child:BarcodeCamera(
                types: const [
                  BarcodeType.ean8,
                  BarcodeType.ean13,
                  BarcodeType.code128,
                ],
                position: CameraPosition.back,
                resolution: Resolution.hd720,
                framerate: Framerate.fps30,
                mode: DetectionMode.pauseVideo,
                onScan: (code) {
                  setState(() async {
                    barcode = code.value;
                    try {
                      final dio = Dio();
                      final response = await dio.get('http://api.promobut.com/v1/produit/scanQRcode',
                          data: {
                            "code": "$barcode"
                          });

                      final data = response.data['data'] as List<dynamic>;

                      for (final item in data) {
                        id.add(item['id'].toString());


                          // montant: item['montant'],
                          productName.add(item['produit']);
                          montant.add(item['montant'].toString());
                          // montantRembourse: item['montantRembourse'],

                          qrCode.add(item['QRcode']);
                          // datefinal : item['dateFinale'],

                      }
                      setState(() {

                        if(barcode == qrCode[qrCode.length - 1]){
                          test = 1;
                        }
                      });


    setState(() {
      CashHelper.putData(key: "productRem", value: productName);
      CashHelper.putData(key: "qrCode", value: qrCode);
      CashHelper.putData(key: "montant", value: montant);
      print("/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////$qrCode");
      print(productName);
      print(id);
      CashHelper.putData(key: "idRem", value: id);
    });









                    }catch(error){
                     setState(() {

                         test = 2;
                       
                     });
                      print(error);
                    }

                      // await getProductData(barcode!).then((value) {
                      //   setState(() {
                      //     print("ssssssssssssssssssssssssssss${productList[0].qrcode}");
                      //     print(barcode);
                      //     if(barcode == productList[0].qrcode){
                      //       test = 1;
                      //     }
                      //   });
                      // });

                      // print("ttttttttttttttttttttttttttttttttttttttt");
                      // if(barcode != productList[0].qrcode){
                      //   test = 2;
                      // }






                    print(barcode);
                    Timer(Duration(seconds: 1), () {
                      setState(() {
                        test = 0;
                        CameraController.instance.resumeDetector();
                      });
                    },);

                    print(code);
                  });


                },
                children:  [
                  Visibility(
                    visible: test == 2 ? true : false,
                      child: Icon(Icons.cancel_outlined, size: 200, color: Colors.red),
                  ),
                  Visibility(
                    visible: test == 1 ? true : false,
                    child: Icon(Icons.done, size: 200, color: Colors.green),
                  ),


                  MaterialPreviewOverlay(animateDetection: false),

                  // Positioned(
                  //   bottom: 0,
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         width: 450,
                  //         height: 200,
                  //         color: Colors.white,
                  //         child: TextButton(
                  //           onPressed: () =>
                  //               CameraController.instance.resumeDetector(),
                  //           child: Text('Resume'),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ) ,
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 360,
              width: 450,
              color: Colors.white,
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


              // Column(
              //   children: [
              //     Text("$barcode"),
              //     Container(
              //       padding: EdgeInsets.all(10),
              //       width: double.infinity,
              //       height: 100,
              //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              //           color: Colors.grey[200]
              //       ),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //         Row(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Text('1',
              //               style: TextStyle(
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.bold
              //               ),
              //             ),
              //             SizedBox(width: 20,),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text('${productList.length}',
              //                   style: TextStyle(
              //                       fontSize: 20,
              //                       fontWeight: FontWeight.bold
              //                   ),
              //                 ),
              //                 SizedBox(height: 20,),
              //                 Text('123456789',
              //                   style: TextStyle(
              //                       fontSize: 15,
              //                       fontWeight: FontWeight.bold
              //                   ),
              //                 ),
              //               ],
              //             ),
              //
              //
              //           ],
              //         ),
              //
              //         ],
              //       )
              //     ),
              //   ],
              // ),

            ),

          ],
        )


    );
  }

}