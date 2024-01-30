import 'package:trustproducts/View/pages/SettingScreen.dart';
import 'package:trustproducts/config/repository/Bcodes_repo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:barcode_scanner/classical_components/barcode_camera.dart';
import 'package:barcode_scanner/classical_components/classical_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:camera/camera.dart';
import 'package:trustproducts/utils/Files.dart';
import '../../controllers/Home_controllar.dart';
import '../../utils/base_api.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../Functions.dart';
import '/utils/lottie.dart';
import 'package:lottie/lottie.dart';
import 'package:xml/xml.dart';
class homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ScreenSize=MediaQuery.sizeOf(context);
    double H=ScreenSize.height;
    double piece_high=H/10000;
    return Scaffold(
      body: GetBuilder(
        init: HomeControllar(),
        builder: (controllar)=> MaterialButton(
          color:controllar.backgroundColor.value,
          autofocus: false,
          hoverElevation: 0.0,
          enableFeedback: false,
          elevation: 0.0,
          height: double.maxFinite,
          onPressed: ()async{
            await controllar.Scan();
            },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [


                Row(children: [
                  // SizedBox(width:,),
                  IconButton(
                    iconSize: 35,
                          onPressed:()async{  await launchUrl(Uri.parse(API.googleForm),
                          mode:LaunchMode.externalApplication
                      );
                      },
                      icon: Icon(Icons.help_center_outlined)),
                  Spacer(),
                  IconButton(
                    iconSize: 35,
                          onPressed:(){
                     controllar.init();
                          },
                      icon: Icon(Icons.download_for_offline_outlined))
                ],),
                // Spacer(),
                SizedBox(height: piece_high*1000,),
                Visibility(
                    visible: !controllar.Trusted.value,
                    child: Card(
                      borderOnForeground: false,
                      elevation: 0.0,
                      color: AppColor.c2av,
                      child: Column(
                        children: <Widget>[
                          Lottie.asset(lotties.Thumbdown,
                              width: 200,
                              height: piece_high*2100),
                          SizedBox(height: 16,),
                          Text("Untrusted",
                            style: TextStyle(color:AppColor.cBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 26),),

                        SizedBox(height: 2,)
                        ],
                      ),
                    ),
                ),
                Visibility(
                    visible:controllar.Start.value==0,
                    child: Card(
                      borderOnForeground: false,
                      elevation: 0.0,
                      color: AppColor.cWhite,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: piece_high*100,),
                          Lottie.asset(
                              lotties.start,
                              width: 300,
                              height: piece_high*3000),
                          // ),
                        SizedBox(height: 2,)
                        ],
                      ),
                    ),
                ),
                Visibility(
                    visible: controllar.Trusted.value && controllar.Start.value==1,
                    child: Column(
                      children: [
                        Card(
                          elevation: 0.0,
                          color: controllar.backgroundColor.value,
                          child: Column(
                            children: <Widget>[
                              Lottie.asset(lotties.Thumbup,
                              width: 200,
                              height: piece_high*2100),
                              Text("Trusted",
                                style: TextStyle(color:AppColor.cBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26),),
                            ],
                          ),
                        ),
                        SizedBox(height: piece_high*2000,),
                      ],
                    ),
                ),
                // Spacer(),
                Column(children: [
                  Visibility(
                    visible: controllar.DetectedCountry.value!="Unknown",
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: Text("manufacturing process was in : ${controllar.DetectedCountry.value}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColor.cWhite,
                            fontSize: 16,
                            fontFamily: 'Open Sans'
                        ),),
                    ),
                  ),
                  SizedBox(height: piece_high*40,),
                  Visibility(
                    visible: !controllar.Trusted.value,
                    child: Text("manufacture is : ${controllar.manufacture.value}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColor.cWhite,
                          fontSize: 16,
                          fontFamily: 'Open Sans'
                      ),),
                  ),
                ],),
                InkWell(
                  onTap: (){controllar.Scan();},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Tab to scan ...",
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Open Sans'
                        ),),
                    ],
                  ),
                ),


              ],
            ),
        ),
      ),

    );
  }
}