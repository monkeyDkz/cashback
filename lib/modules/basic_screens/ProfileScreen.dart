

import 'dart:io';

import 'package:cash_back/logIn/FirstScreen.dart';
import 'package:cash_back/shared/colors.dart';
import 'package:cash_back/shared/components.dart';
import 'package:cash_back/shared/network/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../others/AccountSreen.dart';
import '../others/ChangePasswordScreen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {

  String? imageSave ;
  String? username;
  String? credit;
  File? image;
  @override
  void initState() {



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    CashHelper.getData(key: 'profile').then((value) {
      setState(() {
        imageSave = value![0];
        image = File(imageSave!);
        Image.file(image!);

      });

    });
    CashHelper.getData(key: 'account').then((value){
      setState(() {
        username = value![0];
        credit = value![1];
      });


    });

    return Scaffold(
      appBar: AppBarComponent(text: 'profile',
      action: [
        IconButton(onPressed: (){
          CashHelper.sharedPreferences!.clear();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreen()));
        }, icon: Icon(Icons.logout,color: mainColor,))
      ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 95,
                    backgroundColor: mainColor,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[400],
                      backgroundImage: image != null ? FileImage(image!) : null,
                      radius: 90,
                      child:image == null ? Image(image: AssetImage('assets/images/avatar.png'),): null

        ),
                  ),SizedBox(height: 10,),
                  Text("$username",style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500
                  ),),

                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SecondText(text: ('my savings'),
             fontSize: 25),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: AchatStats(
                      icon: Icons.shopping_bag,
                      firstText: '$credit TND',
                      secondText: 'In total',),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: AchatStats(
                    icon: Icons.shopping_bag,
                    firstText: '0 TND',
                    secondText: 'Withdraw',),
                ),


              ],
            ),
            SizedBox(
              height: 20,
            ),
            SecondText(text: ('Account'),
                fontSize: 25),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 30,
                        child: Icon(Icons.person,
                          size: 30,
                          color: Colors.grey,),
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$username',style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                          fontWeight: FontWeight.w500),),
                          SizedBox(height: 5,),
                          Text('Personal info',style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 60,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200],
                        ),

                        child: IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountScreen()));
                          },

                          icon: Icon(Icons.arrow_forward_ios,
                            size: 30,
                            color: Colors.black,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Divider(),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 30,
                        child: Icon(Icons.person,
                          size: 30,
                          color: Colors.grey,),
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Security',style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),),
                          SizedBox(height: 5,),
                          Text('Change password',style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 60,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200],
                        ),

                        child: IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePasswordScreen()));
                          },

                          icon: Icon(Icons.arrow_forward_ios,
                            size: 30,
                            color: Colors.black,),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }

}
