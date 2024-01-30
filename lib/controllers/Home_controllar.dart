import 'dart:io';
import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/config/Cashe/CasheHelper.dart';
import 'package:get/get.dart';
import 'package:trustproducts/utils/Files.dart';
import 'package:trustproducts/utils/colors.dart';
import '../View/Functions.dart';
import '../config/repository/Bcodes_repo.dart';
import '/core/model/Bcodes_model.dart';
import '../utils/images.dart';

class HomeControllar extends GetxController {
  HomeControllar._internal();
  static final HomeControllar instance = HomeControllar._internal();
  factory HomeControllar()=> instance;
  RxBool Trusted= true.obs;
  RxInt Start=0.obs;
  RxString Barcode = "+++".obs;
  RxString DetectedCountry = "Unknown".obs;
  RxString manufacture = "Untrusted brand".obs;
  RxList LBCodes=[].obs;
  RxList API_LBCodes=[].obs;
  RxList API_Lpatterns=[].obs;
  RxList API_manufactures=[].obs;
  // RxString TrustIMG=DefaultImages.trusted1.obs;
  Rx<Color> backgroundColor = AppColor.cWhite.obs;
  // Future GetData()async{
  //   API_LBCodes.value= await BcodesRepo.
  // }
  Future init()async{
    await Get_datafromAPI_and_cache_it();
    await Getdatafromcache();
  }
  Future Getdatafromcache()async{
    // final Map<String,dynamic> play =await BcodesRepo.fetchData();
    chache.init();
    final Map<String,dynamic> play =await chache.GetJson(Key: "JsonBC");
    Bcodes_model Model=Bcodes_model.fromJson(play);
    Model.pattern_data?.forEach((element) {RedBarcode.add(element);
    print("doooooooooooooooooooooooooooooooone $element eeeeeeeeeeeeeeeeee");
    });
    Model.Bcodes_data?.forEach((element) {LBCodes.add(element);
    print("doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee$element eeeeeeeeeeeeeeee");});

  }

  Future Get_datafromAPI_and_cache_it()async{
    chache.init();
    chache.SaveJson(Key: "JsonBC", JsonValue: await BcodesRepo.fetchData());

  }



  Future<void> Scan() async{
    // await Getdatafromcache();
    Barcode.value = await scanner().scanBarcode();
    update();
    Digit_Detection_Country();
    update();
    if(Trusted.value){
      Digit_Detection_pattern();
    update();
    }
    if(Trusted.value){
    Bcode_Detection_Country(path: Files.Files4);

    update();
    }
  }

////////////////       detection by degit ////////////////////
void Digit_Detection_Country(){
  String Keycode = "";
  String? country="Unkown";
  Start.value=1;
  Trusted.value=true;
  backgroundColor.value = AppColor.cGreen;
  manufacture.value="Untrusted brand";
  // backgroundColor.value = AppColor.cWhite;
  for (int i = 0; i<3; i++) {
    Keycode += Barcode.value[i];
  }
  if (countryCodes.containsKey(Keycode)) {
    country = countryCodes[Keycode] ;
    DetectedCountry.value= country!;
  }
    if(Barcode.value=="+++"){
      backgroundColor.value = AppColor.cWhite;
      Start.value=0;
    }

  print("===========================================================> $country");

  for(int i=0 ; i<RedCountries.length;i++){
    if(country==RedCountries[i]){
      Trusted.value=false;
      backgroundColor.value = AppColor.c2av;
      print("IM in =======================DigitCountry======================");
      // TrustIMG.value=DefaultImages.untrusted1;
    }
  }
  update();

}

////////////////////// detection by barcodes ////////////////////
  Future<void> Bcode_Detection_Country({required String path})async{
    String? country="Unkown";
    Start.value=1;
    Trusted.value=true;
    backgroundColor.value = AppColor.cGreen;
    manufacture.value="Untrusted brand";
    await ConvertToList(path);
    // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+Barcode.value);
    // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${Barcode.value.runtimeType}");
    if(LBCodes.contains(Barcode.value)){
      print("fffffffffffffffffffffffffffffffffffffffffffffffffffff");
      print(Barcode.value);
      Trusted.value=false;
      backgroundColor.value = AppColor.c2av;
      print("IM in =======================File======================");
    }
    if(Barcode.value=="+++"){
      backgroundColor.value = AppColor.cWhite;
      Start.value=0;
    }
    update();
  }

///////////  to take csv filepath and convert it to list///////////

  Future<void> ConvertToList(String csvFilePath) async {
    List Lbrcodes =LBCodes.value;
    try {
      // Load the CSV file from the app's assets.
      final String csvData = await rootBundle.loadString(csvFilePath);
      // Parse the CSV data using the csv package.
      // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+csvData[0];
      List<List<dynamic>> csvTable = const CsvToListConverter(
        allowInvalid: true,
        shouldParseNumbers: true
      ).convert(csvData);
      // Print the contents of the CSV file.
      // print("==========sssssssssss================>"+csvTable[0].toString());
      for (var row in csvTable) {
        for (var cell in row) {
          // print(cell);
          Lbrcodes.add(cell.toString());
        }
      }
      LBCodes= await Lbrcodes.obs;
      // print("=======================================================================");
      // print(Lbrcodes);
      // print("=======================================================================");
      // print(">>${Lbrcodes[1]}<<");
      // print("=======================================================================");

      // print(Lbrcodes.length);
    } catch (e) {
      print('Error: $e');
    }

  }



////////////////       detection by degit ////////////////////
  void Digit_Detection_pattern(){
    String Keycode = "";
    Start.value=1;
    Trusted.value=true;
    backgroundColor.value = AppColor.cGreen;
    manufacture.value="Untrusted brand";
    for (int i = 0; i<RedBarcode.length; i++) {
      if(Barcode.value.length>=RedBarcode[i].length){
      if(RedBarcode[i]==Barcode.value.substring(0,RedBarcode[i].length)){
        Trusted.value=false;
        backgroundColor.value = AppColor.c2av;
        manufacture.value=manufactures[RedBarcode[i]]??"Untrusted brand";
        print("IM in =======================manufacture============22==========");
        print("IM in =======================${RedBarcode[i]}============22==========");
        print("IM in =======================${Barcode.value.substring(0,RedBarcode[i].length)}============22==========");
        print("IM in =======================$i============22==========");

      }}
    }
    if(API_Lpatterns.value.length>0){
      for (int i = 0; i<API_Lpatterns.value.length; i++) {
        if(Barcode.value.length>=API_Lpatterns.value[i].length){
          if(API_Lpatterns.value[i]==Barcode.value.substring(0,API_Lpatterns.value[i].length)){
            Trusted.value=false;
            backgroundColor.value = AppColor.c2av;
            manufacture.value=API_manufactures.value[i]??"Untrusted brand";
            print("IM in =======================manufacture============22==========");
            print("IM in =======================${API_Lpatterns.value[i]}============22==========");
            print("IM in =======================${Barcode.value.substring(0,API_Lpatterns.value[i].length)}============22==========");
            print("IM in =======================$i============22==========");

          }}
      }
    }

    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+Barcode.value);
    if(Barcode.value=="+++"){
      backgroundColor.value = AppColor.cWhite;
      Start.value=0;
    }

    update();

  }



}

