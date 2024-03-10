import 'package:cash_back/modules/Layout/HomeLayout.dart';
import 'package:cash_back/modules/basic_screens/HistoriqueScreen.dart';
import 'package:cash_back/ScannerScreen.dart';
import 'package:cash_back/modules/basic_screens/RemboursementScreen.dart';
import 'package:cash_back/remboursement/ImageStepScreen.dart';
import 'package:cash_back/remboursement/ScanStepScreen.dart';
import 'package:cash_back/remboursement/ValidationStepScreen.dart';
import 'package:cash_back/shared/colors.dart';
import 'package:cash_back/shared/network/local/cash_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:http/http.dart' as http;
import '../../shared/components.dart';
import '../../shared/network/remote/dio_helper.dart';

class RemboursementStepsScreen extends StatefulWidget {
  const RemboursementStepsScreen({Key? key}) : super(key: key);

  @override
  State<RemboursementStepsScreen> createState() => _RemboursementStepsScreenState();
}

class _RemboursementStepsScreenState extends State<RemboursementStepsScreen> {
  late bool enabled = false;
  int pageIndex =0;
  String text = 'Next';

  PageController? controller = PageController(initialPage: 0);


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.confirm,
            text: 'you will lose u r progreess ...',
            confirmBtnText: 'Yes',
            cancelBtnText: 'No',
            confirmBtnColor: Colors.green,
            onConfirmBtnTap: (){
              Navigator.pop(context);
              Navigator.pop(context);
            }

        );
        return false;

      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarComponent(
            text: 'Refund',
          pop: true,
          pressed: (){

            QuickAlert.show(
              context: context,
              type: QuickAlertType.confirm,
              text: 'you will lose u r progreess ...',
              confirmBtnText: 'Yes',
              cancelBtnText: 'No',
              confirmBtnColor: Colors.green,
              onConfirmBtnTap: (){
                Navigator.pop(context);
                Navigator.pop(context);
              }

            );


          }

        ),
        body:
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              IconStepper(
                lineColor: Colors.black,
                activeStepBorderColor: Colors.black,
                enableNextPreviousButtons: false,
                activeStepBorderWidth: 2,
                enableStepTapping: false,
                activeStepColor: mainColor,
                onStepReached: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                activeStep: pageIndex,
                icons: [
                  Icon(Icons.file_copy_outlined),
                  Icon(Icons.qr_code_scanner),
                  Icon(Icons.send),

                ],
              ),
              Expanded(
                child: PageView(

                  physics:  NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [
                    ImageStepScreen(),
                    ScanStepScreen(),
                    ValidationStepScreen(),



                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NBbutton(pageIndex: pageIndex,
                      pressed: (){
                        setState(() {
                          pageIndex==0?pageIndex:pageIndex-=1;
                        });
                        print(controller!.page);
                        controller!.previousPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                      },
                      text: 'Back',
                      iconFirst: Icons.arrow_back_ios

                  ),
                  NBbutton(pageIndex: 1,
                      pressed: () async {

                          if(pageIndex!=2){

                            setState(() {

                            pageIndex+=1;});

                          }
                          else{


                            CashHelper.getDataString(key: 'image').then((value) async {
                              if (value != null) {
                                print(value);
                                String fileName = value.split('/').last;
                                print(fileName);
                                var request = http.MultipartRequest(
                                  'POST',
                                  Uri.parse('http://api.promobut.com/v1/demande/addDemande'),
                                );
                                request.files.add(
                                  await http.MultipartFile.fromPath(
                                    'receipt',
                                    value,
                                    //  filename: _imageFile!.path.split("/").last,
                                    //  contentType: MediaType('image', 'png'),

                                  ),
                                );
                                CashHelper.getData(key: 'idRem').then((value) {
                                  print("$value product_id");

                                  String myString = value!.join(',');
                                  print("$myString product_id");
                                  request.fields['listeProduit'] = myString;
                                });
                                // Add the 'listeProduit' field


                                // Add the 'user_id' field
                                CashHelper.getData(key: 'account').then((value) {
                                  String  userId = value![2];

                                  request.fields['user_id'] = userId;
                                });


                                var response = await request.send();

                                if (response.statusCode == 200) {
                                  // Successful API call
                                  var responseData = await response.stream.bytesToString();
                                  // Process the responseData
                                  print(responseData);
                                  CashHelper.removeData(key: 'image');
                                  CashHelper.removeData(key: 'idRem');
                                  CashHelper.removeData(key: 'qrCode');
                                  CashHelper.removeData(key: 'productRem');
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    text: 'Remboursement has been send it Successfully!',
                                    onConfirmBtnTap: (){
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeLayout()));
                                    }
                                  );

                                } else {
                                  // Handle the error
                                  print('Error: ${response.reasonPhrase}');
                                }
                              }
                            });










                          }





                        controller!.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);




                      },
                      text: pageIndex!= 2 ? 'Next' : "Confirm",
                      iconSecond: Icons.arrow_forward_ios

                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
