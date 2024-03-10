import 'package:cash_back/ScannerScreen.dart';
import 'package:cash_back/modules/Layout/RemboursementSteps.dart';
import 'package:cash_back/shared/colors.dart';
import 'package:cash_back/shared/components.dart';
import 'package:cash_back/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../logIn/FirstScreen.dart';
import '../../shared/network/local/cash_helper.dart';

class RemboursementScreen extends StatefulWidget {
  const RemboursementScreen({Key? key}) : super(key: key);

  @override
  State<RemboursementScreen> createState() => _RemboursementScreenState();
}

class _RemboursementScreenState extends State<RemboursementScreen> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(text: 'Refund',
      pop: true,
      pressed: (){
        Navigator.pop(context);
      }),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RemboursementSteps(
                      id: 1,
                      number: "1",
                      text: "Photograph your entire proof of purchase",
                      icon: Icons.file_copy_outlined),
                  RemboursementSteps(
                      id: 2,
                      number: "2",
                      text: "Scan Bar Code",
                      icon: Icons.qr_code),
                  RemboursementSteps(
                      id: 3,
                      number: "3",
                      text: "Submit ",
                      icon: Icons.check),
                  SizedBox(
                    height: 20,
                  ),
                  LoginButton(ContainerColor: mainColor,
                    text: 'Start Refund',
                    pressed: () async {
                      CashHelper.getData(key: 'account').then((value){
                        setState(() {
                          if(value?[2] != null){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => const RemboursementStepsScreen()));
                          }
                          else{
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => const FirstScreen()));
                          }

                        });


                      });



                    },),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
