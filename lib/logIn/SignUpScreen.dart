import 'package:cash_back/logIn/FirstScreen.dart';
import 'package:cash_back/logIn/SignInScreen.dart';
import 'package:cash_back/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';

import '../modules/Layout/HomeLayout.dart';
import '../shared/components.dart';
import '../shared/network/remote/dio_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController password1Controller = new TextEditingController();
  bool isPassword = true;
  bool isPassword1 = true;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(
          text: 'Sign up',
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
                        return'Your Username is missing';
                      }
                    },
                    label: 'Username',
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
                defaultFormField(
                    tab: (){
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar();
                    },
                    contoller: password1Controller,
                    type: TextInputType.visiblePassword,
                    validate: (String value){
                      if(value.isEmpty){
                        return'Your password is missing';
                      }

                    },
                    label: 'Confirm Password',

                    isPassword: isPassword1,
                    prefix: Icons.lock,
                    suffix: isPassword1 ? Icons.visibility : Icons.visibility_off,
                    suffixPressed: (){
                      setState(() {
                        isPassword1 = !isPassword1;
                      });

                    }
                ),
                SizedBox(
                  height: 20,
                ),
                LoginButton(ContainerColor: mainColor,
                    text: 'SignUp',
                    pressed: (){
                      if(formKey.currentState!.validate()){
                        if(passwordController.text == password1Controller.text){
                          DioHelper.postData(url:'user/signup',data:
                          {
                            "username":"${emailController.text}",
                            "password":"${password1Controller.text}",
                            "role":["ROLE_MASTER"]
                          }
                          ).then((value) {
                            print(value.data);
                            print(value.data['status']);
                            if(value.data['status']=="success"){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) => const SignInScreen()));
                            }

                          });
                        }


                      }



                      // AnimatedSnackBar.material(
                      //   'This a snackbar with info type',
                      //   type: AnimatedSnackBarType.info,
                      // ).show(context);
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
                        Text("You have already an account ",style: TextStyle(color: Colors.grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),),
                        SizedBox(width: 10,),
                        TextButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => const SignInScreen()));

                          },
                          child: Text("Login",style: TextStyle(color: mainColor,
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
}
