import 'package:flutter/material.dart';
import 'package:trustproducts/utils/colors.dart';
import 'package:get/get.dart';
import 'package:barcode_scanner/barcode_scanning_data.dart';
import 'View/Functions.dart';
import 'View/pages/homeScreen.dart';
import 'config/repository/Bcodes_repo.dart';
import 'controllers/Home_controllar.dart';
void main() {

  runApp( MyApp());

}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color:AppColor.cWhite,
        )
      ),
      title: 'Trust products',
      debugShowCheckedModeBanner: false,
      home:FutureBuilder(
        // initialData: HomeControllar.instance.Getdatafromcache(),
          builder:(context,AsyncSnapshot snapshot){
            return homescreen();}
        , future: HomeControllar.instance.init(),
        ),

    );
  }
}


