import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import '../../../ApiService/ApiFactory.dart';
import '../../../ApiService/ConnectorController.dart';
import '../../../CommonModel/DropDownValue.dart';
import '../../../Utils/shared_preferences_keys.dart';
import '../../../Widgets/MyWidget.dart';

import 'package:pdf/widgets.dart' as pw;

import '../UserDetailsModel.dart';

class DashboardscreenController extends GetxController {
  //TODO: Implement DashboardscreenController

  final count = 0.obs;
  ByteData? bytes;
  Uint8List? byteList;
  var ttf;
  double fontSize = 20;

  TextEditingController searchTextEditingController = TextEditingController();

  ScreenshotController screenshotController = ScreenshotController();
  DropDownValue ?selectedState = DropDownValue(key:"1" ,value:"Odisha" );
  Rxn<DropDownValue> ?selectedDistrict = Rxn<DropDownValue>();
  Rxn<DropDownValue> ?selectedAssembly = Rxn<DropDownValue>();
  // Rxn<UserDetailsModel> ?sele = Rxn<UserDetailsModel>();

  // Rxn<DropDownValue> districtLst = Rxn<DropDownValue>() ;

  var districtLst = RxList<DropDownValue>();
  var assemblyLst = RxList<DropDownValue>();
  var userDetails = RxList<UserDetailsModel>();
  var userDetailsMaster = RxList<UserDetailsModel>();
  String ? electionDate;
  Future<String>getImageData() async {
    MyWidgets.showLoading3();
    bytes = await rootBundle.load('assets/images/bjp.png');
    byteList = bytes?.buffer.asUint8List();
    final font = await rootBundle.load("assets/font/Nirmala.ttf");
    ttf = pw.Font.ttf(font);
    Get.back();
    return "";
  }
  String ? userName ="";
  getLocalData() async {

    userName = await SharedPreferencesKeys().getStringData(key: "userName");

    String? district = await SharedPreferencesKeys().getStringData(key: "district");
    String? districtId = await SharedPreferencesKeys().getStringData(key: "districtId");

    String? assembly = await SharedPreferencesKeys().getStringData(key: "assembly");
    String? assemblyId = await SharedPreferencesKeys().getStringData(key: "assemblyId");

    selectedDistrict?.value = DropDownValue(key:districtId??"" ,value:district??"" );

    selectedAssembly?.value = DropDownValue(key:assemblyId ,value:assembly );

    selectedDistrict?.refresh();
    selectedAssembly?.refresh();
    getUserDetailsApiCall();
  }

  getSearchDetails(String? text){
    if(text != null && text != ""){
      userDetails.clear();
      userDetails.value =  userDetailsMaster.where((e) => e.voterName.toString().contains(text)).toList();
      userDetails.refresh();
    }else{
      userDetails.clear();
      // userDetails = userDetailsMaster;
      for (var element in userDetailsMaster) {
        userDetails.add(element);
      }

      userDetails.refresh();
    }

  }

  sendWhatsappMessage(UserDetailsModel data) async {
    // final Uri uri = Uri.file(XFile.fromData(data).path);
    // await launchUrl(uri);
    await launch("https://wa.me/${7008021012}?text=ଆଶାୟୀ ପ୍ରାର୍ଥୀ \n ${userName}\n ଭୋଟ ଦେଇ ଜୟଯୁକ୍ତ କରାନ୍ତ \n ଆଳି ବିଧାନସଭା ନର୍ବାଚନମଣ୍ଡଳୀ ୨୦୨୪ \n ବୁଥ୍ ନଂ:${data.boothNo}\n କ୍ରମିକ ନଂ:${data.serialNo} \n ନାମ: ${data.voterName} \n ମତଦାନ କେନ୍ଦ୍ର:${data.constituencyName} \n ମତଦାନ ତାରିଖ:$electionDate \n ଭୋଟର ଇଡି:${data.voter_id}");

    // await WhatsappShare.shareFile(
    //   text: 'Whatsapp share text',
    //   phone: '9178109440',
    //   filePath: [XFile.fromData(data).path],
    // );
  }


  textMe(UserDetailsModel data) async {
    // Android
    var uri = 'sms:+91 ${7008021012}?body=ଆଶାୟୀ ପ୍ରାର୍ଥୀ \n $userName\n ଭୋଟ ଦେଇ ଜୟଯୁକ୍ତ କରାନ୍ତ \n ଆଳି ବିଧାନସଭା ନର୍ବାଚନମଣ୍ଡଳୀ ୨୦୨୪ \n ବୁଥ୍ ନଂ:${data.boothNo}\n କ୍ରମିକ ନଂ:${data.serialNo} \n ନାମ: ${data.voterName} \n ମତଦାନ କେନ୍ଦ୍ର:${data.constituencyName} \n ମତଦାନ ତାରିଖ:$electionDate \n ଭୋଟର ଇଡି:${data.voter_id}';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      var uri = 'sms:+91 ${7008021012}?body=ଆଶାୟୀ ପ୍ରାର୍ଥୀ \n $userName\n ଭୋଟ ଦେଇ ଜୟଯୁକ୍ତ କରାନ୍ତ \n ଆଳି ବିଧାନସଭା ନର୍ବାଚନମଣ୍ଡଳୀ ୨୦୨୪ \n ବୁଥ୍ ନଂ:${data.boothNo}\n କ୍ରମିକ ନଂ:${data.serialNo} \n ନାମ: ${data.voterName} \n ମତଦାନ କେନ୍ଦ୍ର:${data.constituencyName} \n ମତଦାନ ତାରିଖ:$electionDate \n ଭୋଟର ଇଡି:${data.voter_id}';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }


  getDistrictApiCall() async {
    electionDate = await SharedPreferencesKeys().getStringData(key: "election_date");

    MyWidgets.showLoading3();
    Get.find<ConnectorController>().GETMETHODCALL(
        api: "${ApiFactory.GET_DISTRICT}${selectedState?.key??""}",
        // json: sendData,
        fun: (map) async {
          Get.back();
          if(map is List && map.isNotEmpty){
            List<DropDownValue> dataList = [];
            for (var element in map) {
              dataList.add(DropDownValue.fromJsonDynamic(element, "district_id", "district_name"));
            }
            districtLst.value = dataList;
            districtLst.refresh();
          }
          // log(">>>>>${jsonEncode(map)}");
        });
  }

  getAssemblyApiCall(String? id) async {
    await SharedPreferencesKeys().setStringData(key: "district", text:selectedDistrict?.value?.value??"");
    await SharedPreferencesKeys().setStringData(key: "districtId", text:selectedDistrict?.value?.key??"");
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().GETMETHODCALL(
        api: "${ApiFactory.GET_ASSEMBLY_CONSTINUENCY}${id??""}",
        // json: sendData,
        fun: (map) async {
          Get.back();
          if(map is List && map.isNotEmpty){
            List<DropDownValue> dataList = [];
            for (var element in map) {
              dataList.add(DropDownValue.fromJsonDynamic(element, "constituency_id", "constituency_name"));
            }
            assemblyLst.value = dataList;
            assemblyLst.refresh();
          }

          // log(">>>>>${jsonEncode(map)}");
        });
  }

  getUserDetailsApiCall()  async {
    await SharedPreferencesKeys().setStringData(key: "assembly", text:selectedAssembly?.value?.value??"");
    await SharedPreferencesKeys().setStringData(key: "assemblyId", text:selectedAssembly?.value?.key??"");

    MyWidgets.showLoading3();
    Get.find<ConnectorController>().GETMETHODCALL(
        api: "${ApiFactory.GET_USER_DETAILS}&state_id=${selectedState?.key}&district_id=${selectedDistrict?.value?.key??""}&assembly_id=${selectedAssembly?.value?.key}",
        // json: sendData,
        fun: (map) async {
          Get.back();
          if(map is List && map.isNotEmpty){
            List<UserDetailsModel> dataList = [];
            for (var element in map) {
              dataList.add(UserDetailsModel.fromJson(element));
            }
            userDetails.value = dataList;
            List<UserDetailsModel> dataListNew = [];
            for (var element in dataList) {
              dataListNew.add(element);
            }

            userDetailsMaster.value = dataListNew;
            userDetails.refresh();
          }else{
            userDetails.clear();
            userDetailsMaster.clear();
            userDetails.refresh();
          }
          log(">>>>>${jsonEncode(map)}");
        });
  }


  @override
  void onInit() {
    getLocalData();
    super.onInit();
  }

  @override
  void onReady() {
    getDistrictApiCall();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
