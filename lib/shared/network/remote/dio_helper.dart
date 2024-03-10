

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static String? basicAuth;
  static late  Dio dio;
  static String baseUrl = "http://api.promobut.com/v1/";
  static String? error = null;
  static String? errorDescreption = null;
  // https://jsonplaceholder.typicode.com/abcdefghijklmnopqrxyz
  static init(GlobalKey<ScaffoldMessengerState> _scaffoldKey){
    dio = Dio(

      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: Duration(seconds: 15),
        receiveTimeout: Duration(seconds: 15),



      )
    );

    String username = 'sydemo';
    String password = '123456789';
    basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));



    dio.options.extra['withCredentials'] = true;
    dio.interceptors.add(
      InterceptorsWrapper(


        onError: (DioError e, ErrorInterceptorHandler handler) {
          print('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
          switch(e.response?.statusCode) {
            case 400: {
              error = "Authentication Fail";
              errorDescreption = "Please login again";
            }
            break;
            case 403: {
              error = "Authentication Fail";
              errorDescreption = "Please login again";
            }
            break;
            case 401: {
              error = "Authentication Fail";
              errorDescreption = "Please login again";
            }
            break;
            case 404: {
              error = "Not Found";

            }
            break;
            case 500: {
              error = "Internal server Error";

            }
            break;
            case 508: {
              error = "Time Out";

            }
            break;

            default: {
             error = "Error";
            }
            break;
          }
          if (error != null) {
            // show SnackBar if error field is not null
            _scaffoldKey.currentState!.showSnackBar(SnackBar(content:
            Column(
              children: [
                Text("$error"),
                errorDescreption != null ? Text("$errorDescreption") : Text("test"),
              ],
            ),
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 3),


            ) );
          }

          return handler.next(e);
        },
      ),
    );




  }

  static Future<Response> getData ({
    required String url,
     Object? data,

  }) async {
    return await dio.get(url,data:data);
  }
  static Future<Response> postData ({
    required String url,
    required Object data


  }) async {
    return await dio.post(url, data:data);
  }
  static Future<Response> postDatat ({
    required String url,
    required Object data


  }) async {
    return await dio.post(url, data:data,options: Options(headers: {
      'Authorization': basicAuth
    }));
  }

}