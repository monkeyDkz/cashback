import 'package:shared_preferences/shared_preferences.dart';

class CashHelper
{
  static SharedPreferences? sharedPreferences;
  static init() async
  {
   sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool?> putData({
  required String key,
  required List<String> value
})async
      {

       return await sharedPreferences?.setStringList(key,value);
  }

  static Future<List<String>?> getData(
  {
    required String key
}
      )async
  {

    return await sharedPreferences?.getStringList(key);
  }
  static Future<bool?> putDataString({
    required String key,
    required String value
  })async
  {

    return await sharedPreferences?.setString(key,value);
  }
  static Future<String?> getDataString(
      {
        required String key
      }
      )async
  {

    return await sharedPreferences?.getString(key);
  }
  static Future<bool?> removeData(
      {
        required String key
      }
      )async
  {

    return await sharedPreferences?.remove(key);
  }
}
