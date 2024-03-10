



import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cash_back/logIn/FirstScreen.dart';
import 'package:cash_back/logIn/SignUpScreen.dart';
import 'package:cash_back/modules/Layout/HomeLayout.dart';
import 'package:cash_back/shared/network/local/cash_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/src/icon_data.dart';
export 'package:font_awesome_flutter/src/fa_icon.dart';
export 'package:font_awesome_flutter/src/icon_data.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cash_back/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../shared/components.dart';
import '../shared/network/remote/dio_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool isPassword = true;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarComponent(
              text: 'Sign in',
              pressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (contex) => const FirstScreen()));
              },
             pop: true,
              center: true
          ),
          body:Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/logo-app.png'),height: 200,width: 250,),
                    SizedBox(height: 30,),
                    defaultFormField(
                        contoller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value){
                          if(value.isEmpty){
                            return'Your password is missing';
                          }
                        },
                        label: 'Email',
                        prefix: Icons.mail_outline
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                     tab: (){
                       ScaffoldMessenger.of(context)
                         ..hideCurrentSnackBar();
                     },
                        contoller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (String value){
                          if(value.isEmpty){
                            return'Your password is missing';
                          }

                        },
                        label: 'Password',

                        isPassword: isPassword,
                        prefix: Icons.lock,
                        suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                        suffixPressed: (){
                          setState(() {
                            isPassword = !isPassword;
                          });

                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    LoginButton(ContainerColor: mainColor,
                        text: 'SignIn',
                        pressed: (){
                          if(formKey.currentState!.validate()){

                            DioHelper.getData(url: 'login_check',data:
                            {
                              "username": "${emailController.text}",
                              "password": "${passwordController.text}"
                            }
                            ).then((value) {
                              print(value.data['status']);
                              if(value.data['status']==1){
                                List<String> data = [];
                                data.add(value.data['user']);
                                data.add(value.data['credit'].toString());
                                data.add(value.data['id'].toString());

                                CashHelper.putData(key: 'account', value: data);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) =>  HomeLayout()));
                              }

                            });
                          }



                          // vcxvcwv
                        }
                        //   final materialBanner = MaterialBanner(
                        //     /// need to set following properties for best effect of awesome_snackbar_content
                        //     elevation: 0,
                        //     backgroundColor: Colors.transparent,
                        //     forceActionsBelow: true,
                        //     content: AwesomeSnackbarContent(
                        //       title: 'Oh Hey!!',
                        //       message:
                        //       'This is an example error message that will be shown in the body of materialBanner!',
                        //
                        //       /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        //       contentType: ContentType.failure,
                        //       // to configure for material banner
                        //       inMaterialBanner: true,
                        //     ),
                        //     actions: const [SizedBox.square()],
                        //   );
                        //
                        //   ScaffoldMessenger.of(context)
                        //     ..hideCurrentMaterialBanner()
                        //     ..showMaterialBanner(materialBanner);
                      //},
                        ),

                    SizedBox(
                      height: 20,
                    ),
                    Column(

                      children: [

                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withOpacity(0.2),
                                height: 50,
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "Or login with",style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                              ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withOpacity(0.2),
                                height: 50,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  ),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 2
                                  ),
                                  color: Colors.white,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.withOpacity(0.5),
                                  //     spreadRadius: 5,
                                  //     blurRadius: 7,
                                  //     offset: Offset(0, 2), // changes position of shadow
                                  //   ),
                                  // ],

                                ),
                                child: SignInButtonBuilder(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                    onPressed: (){},
                                    text: 'Google',
                                  textColor: Colors.black,

                                height: 50,
                                image:  Container(
                                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    image: AssetImage(

                                   'assets/logos/google_light.png',

                      package: 'flutter_signin_button',
                    ),
                    height: 36.0,
                  ),
                ),
            ),
                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  ),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 2
                                  ),
                                  color: Colors.white,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.withOpacity(0.5),
                                  //     spreadRadius: 5,
                                  //     blurRadius: 7,
                                  //     offset: Offset(0, 2), // changes position of shadow
                                  //   ),
                                  // ],

                                ),
                                child: SignInButtonBuilder(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,

                                  backgroundColor: Colors.white,
                                  onPressed: (){},
                                  text: 'Facbook',
                                  textColor: Colors.black,


                                  height: 50,
                                  iconColor: Colors.blue,
                                 icon: const IconDataBrands(0xf082),
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 20,),

                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",style: TextStyle(color: Colors.grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),),
                            SizedBox(width: 10,),
                            TextButton(
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) => const SignUpScreen()));

                              },
                              child: Text("Register",style: TextStyle(color: mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),),
                            )
                          ],
                        ),


                      ],
                    ),


                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
