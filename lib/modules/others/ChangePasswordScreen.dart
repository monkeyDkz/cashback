import 'package:cash_back/modules/basic_screens/ProfileScreen.dart';
import 'package:flutter/material.dart';

import '../../shared/colors.dart';
import '../../shared/components.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPassword = new TextEditingController();
  TextEditingController newPassword = new TextEditingController();
  TextEditingController newPassword1 = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: mainColor,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilScreen()));
                },
                icon: const Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              ),
            ),
          ),],

      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/security.png'),height: 300,width: 300,),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: defaultFormField(
                contoller: oldPassword,


                type: TextInputType.text,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }
                },
                label: 'Old password',
                prefix: Icons.lock,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: defaultFormField(
                contoller: oldPassword,


                type: TextInputType.text,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }
                },
                label: 'New password',
                prefix: Icons.lock,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: defaultFormField(
                contoller: oldPassword,


                type: TextInputType.text,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }
                },
                label: 'Confirm password',
                prefix: Icons.lock,
              ),
            ),


          ],
        ),
      ),
    );
  }
}
