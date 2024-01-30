import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class chache{

  static SharedPreferences Pref=chache.Pref;
  static init()async {
    Pref=await SharedPreferences.getInstance();
  }

  static Future SaveList({required String Key,required List<String> Value })async{

     await Pref.setStringList(Key, Value);


  }
  static Future GetList({required String Key }) async{

    return  await Pref.getStringList(Key);
  }
  static Future SaveJson({required String Key,required Map<String, dynamic> JsonValue })async{
    String Value=jsonEncode(JsonValue);
     await Pref.setString(Key, Value);


  }
  static Future GetJson({required String Key }) async{
    String jsonString = Pref.getString(Key) ?? '';
    Map<String,dynamic> JsonMAp =jsonDecode(jsonString);
    return JsonMAp ;
  }

}