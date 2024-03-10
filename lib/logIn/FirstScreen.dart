

import 'package:cash_back/modules/Layout/HomeLayout.dart';
import 'package:cash_back/logIn/SignInScreen.dart';
import 'package:cash_back/logIn/SignUpScreen.dart';
import 'package:cash_back/shared/colors.dart';
import 'package:cash_back/shared/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../modules/Layout/HomeLayout1.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/images/logo-app.png'),height: 200,width: 250,),
                Text('app that refunds your purchases',style: TextStyle(
                    color: textColors,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,),
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 4,
                    child: Lottie.asset(
                      'assets/images/shoping.json',
                      height: 50,
                      width: double.infinity,
                      fit: BoxFit.contain
                      ,
                    ),
                  ),
                ),
               LoginButton(
                   ContainerColor: mainColor,
                   text: 'SignUp',
                 pressed: (){
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (contex) => const SignUpScreen()));

                 }
               ),
                SizedBox(
                  height: 10,
                ),
                LoginButton(
                    ContainerColor: secondTextColor,
                    text: 'SignIn',
                  pressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => const SignInScreen()));

                },),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) =>  HomeLayout()));
                  },
                  child: Text('Plus tard',style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
