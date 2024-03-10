import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cash_back/shared/colors.dart';
import 'package:cash_back/shared/network/local/cash_helper.dart';
import 'package:cash_back/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';


class ImageStepScreen extends StatefulWidget {
  const ImageStepScreen({Key? key}) : super(key: key);

  @override
  State<ImageStepScreen> createState() => _ImageStepScreenState();
}

class _ImageStepScreenState extends State<ImageStepScreen> {
  
  File? _imageFile;
  XFile? _pickedImage;
  Uint8List? _bytes;
  @override

  @override
  Widget build(BuildContext context) {

      CashHelper.getDataString(key: "image").then((value) {

        setState(() {
          _imageFile = File(value!);
        });

      });


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child:
      Container(
        width: 300,
          height: 300,



          decoration: BoxDecoration(
            border: Border.all(
               color: mainColor,
              width: 3
            ),),
          child: TextButton(
            onPressed: (){
              cameraImage();
            },
            child: Column(
              children: [

                Flexible(
                                child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,

                            decoration: BoxDecoration(
                            color: Colors.black12,),
                                  child: _imageFile == null
                                      ? Center(child: Text("Pick Recipt"))
                                      :  Image.file(
                                    _imageFile!,
                                    fit: BoxFit.cover,
                                  ),


                                   ),
                                ),
              ],
            ),
          ))
      ),
    );
  }

  Future cameraImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;
    setState(() {
      _imageFile = File(pickedImage.path);
    });

    File resizedFile = await resizeImage(_imageFile!, 500, 500);

    CashHelper.putDataString(key: "image", value: resizedFile.path);

  }
  Future<File> resizeImage(File imageFile, int width, int height) async {
    // Read the file
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

    // Resize the image
    img.Image resizedImage = img.copyResize(image!, width: width, height: height);

    // Get the temporary directory path
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    // Save the resized image to the temporary directory
    File resizedFile = File('$tempPath/resized_image.jpg')
      ..writeAsBytesSync(img.encodeJpg(resizedImage));

    return resizedFile;
  }
// Future cameraImage() async {
  //   String _image;
  //   final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (pickedImage == null) return;
  //   setState(() {
  //     CashHelper.putDataString(key: "image", value: pickedImage.path);
  //     CashHelper.getDataString(key: "image").then((value) async {
  //       _imageFile = File(value!);
  //       print("ttttttt${value.toString()}");
  //       print("kkkkkkkkkkkkkkkkkkk${value}");
  //       String fileName = value.toString().split('/').last;
  //       FormData formData = FormData.fromMap({
  //         "receipt": await MultipartFile.fromFile(value.toString(), filename:fileName),
  //         "listeProduit": "1,3,4",
  //         "user_id":3
  //
  //       });
  //       print(formData);
  //       DioHelper.postData (url: "demande/addDemande",
  //         data: formData,
  //       ).then((value) {
  //         print(value.data);
  //       }
  //       ).catchError((error){
  //         print(error.toString());
  //         print('tr');
  //         print(error.response!.data);
  //       });
  //
  //     });
  //
  //   });
  //   print(pickedImage.path);
  //
  //
  //
  //
  //
  //
  //
  // }
}
