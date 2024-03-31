import 'dart:async';

import 'package:election/app/Widgets/MyWidget.dart';
import 'package:election/app/modules/dashboardscreen/UserDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../AppTheme/Theme.dart';
import '../../../AppTheme/text_styles.dart';
import '../../../CommonModel/DropDownValue.dart';
import '../../../Utils/shared_preferences_keys.dart';
import '../../../Widgets/DropDown.dart';
import '../../../Widgets/common_appbar_view.dart';
import '../../../Widgets/common_card.dart';
import '../../../Widgets/common_search_bar.dart';
import '../../../Widgets/remove_focuse.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboardscreen_controller.dart';

// import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DashboardscreenView extends GetView<DashboardscreenController> {
  DashboardscreenView({Key? key}) : super(key: key);

  @override
  DashboardscreenController controller = Get.find<DashboardscreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView1(
              iconData: Icons.arrow_back,
              titleText: "Election Commission of India",
              onBackClick: () {
                Navigator.pop(context);
              },
              calFun: () async {
                await SharedPreferencesKeys().setStringData(key: "userName", text: "");
                await SharedPreferencesKeys().setStringData(key: "election_date", text: "");
                await SharedPreferencesKeys().setStringData(key: "isLogin", text: "false");
                Get.offAllNamed(Routes.LOGINPAGE);
              },
            ),
            Expanded(
              child: Container(
                height: Get.height * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.grey.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("State: ", style: TextStyles(context).getBoldStyle()),
                                      Text("Odisha", style: TextStyles(context).getRegularStyle())
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                                  child: Obx(() {
                                    return DropDown.formDropDown1WidthMap1(
                                      controller.districtLst.value,
                                          (value) {
                                        controller.selectedDistrict?.value = value;
                                        controller.getAssemblyApiCall(
                                            controller.selectedDistrict?.value?.key ?? "");
                                      },
                                      "District: ",
                                      .67,
                                      autoFocus: false,
                                      titleInLeft: true,
                                      dialogHeight: 178,
                                      titleWidth: 60,
                                      // isEnable:  controllerX.isEnable,
                                      selected: controller.selectedDistrict?.value,
                                      // inkWellFocusNode: controllerX.languageFocus
                                    );
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                                  child: Obx(() {
                                    return DropDown.formDropDown1WidthMap1(
                                      controller.assemblyLst.value ?? [],
                                          (value) {
                                        controller.selectedAssembly?.value = value;
                                        controller.getUserDetailsApiCall();
                                      },
                                      "Assembly: ",
                                      .67,
                                      autoFocus: false,
                                      titleInLeft: true,
                                      titleWidth: 60,
                                      // isEnable:  controllerX.isEnable,
                                      selected: controller.selectedAssembly?.value,
                                      // inkWellFocusNode: controllerX.languageFocus
                                    );
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35, right: 12, top: 5, bottom: 5),
                                  child: CommonCard(
                                    color: AppTheme.backgroundColor,
                                    radius: 36,
                                    child: CommonSearchBar(
                                      // textEditingController: myController,
                                      controller: controller.searchTextEditingController,
                                      onChange: (val) {
                                        print(">>>>>>>>>${val}");
                                        controller.getSearchDetails(val);
                                      },
                                      iconData: FontAwesomeIcons.search,
                                      enabled: true,
                                      text: "Search",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),


                      SizedBox(
                        height: 2,
                      ),
                      Divider(
                        height: 1,
                      ),
                      Obx(() {
                        return SizedBox(
                          height: Get.height * 0.7,
                          child: (controller.userDetails != null &&
                                  controller.userDetails.isNotEmpty)
                              ? ListView.separated(
                                  padding: const EdgeInsets.all(0),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Card(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text("କ୍ରମିକ ନଂ: "),
                                                  Text(controller
                                                          .userDetails.value[index].serialNo ??
                                                      ""),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text("ନାମ: "),
                                                  Text(controller
                                                          .userDetails.value[index].voterName ??
                                                      ""),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("ନିର୍ବାଚନ ତାରିଖ: "),
                                                  Text(controller.electionDate ?? ""),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("ବୁଥ ନଂ: "),
                                                  Text(
                                                      controller.userDetails.value[index].boothNo ??
                                                          ""),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("ଲିଙ୍ଗ: "),
                                                  Text(controller.userDetails.value[index].gender ??
                                                      ""),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("ନିର୍ବାଚନ କେନ୍ଦ୍ର: "),
                                                  Text(controller.userDetails.value[index]
                                                          .constituencyName ??
                                                      ""),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("ଭୋଟର ଇଡି: "),
                                                  Text(controller.userDetails.value[index]
                                                          .voter_id ??
                                                      ""),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        controller
                                                            .getImageData()
                                                            .then((value) async {
                                                          if (controller.byteList != null) {
                                                            Printing.layoutPdf(
                                                              // [onLayout] will be called multiple times
                                                              // when the user changes the printer or printer settings
                                                              onLayout: (PdfPageFormat format) {
                                                                // Any valid Pdf document can be returned here as a list of int
                                                                return buildPdf1(
                                                                    format,
                                                                    controller
                                                                        .userDetails.value[index]);
                                                              },
                                                            );
                                                          }
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          FontAwesomeIcons.print,
                                                          color: Colors.black,
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      buildPdf1(PdfPageFormat.standard,
                                                              controller.userDetails.value[index])
                                                          .then((value) {
                                                        controller.textMe(
                                                            controller.userDetails.value[index]);
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        FontAwesomeIcons.sms,
                                                        color: Colors.redAccent,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      buildPdf1(PdfPageFormat.standard,
                                                              controller.userDetails.value[index])
                                                          .then((value) {
                                                        controller.sendWhatsappMessage(
                                                            controller.userDetails.value[index]);
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        FontAwesomeIcons.whatsapp,
                                                        color: Colors.teal,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                      onTap: () async {
                                                        controller
                                                            .getImageData()
                                                            .then((value) async {
                                                          if (controller.byteList != null) {
                                                            Printing.sharePdf(
                                                                bytes: await buildPdf1(
                                                                    PdfPageFormat.standard,
                                                                    controller
                                                                        .userDetails.value[index]));
                                                          }
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          FontAwesomeIcons.share,
                                                          color: Colors.teal,
                                                        ),
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: controller.userDetails.length,
                                  separatorBuilder: (BuildContext context, int index) {
                                    return Divider(
                                      height: 1,
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text("Data not found"),
                                ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Uint8List> buildPdf(PdfPageFormat format) async {
    // Create the Pdf document
    double inch = 72.0;
    double cm = inch / 2.54;
    final pw.Document doc = pw.Document();

    // Add one page with centered text "Hello World"
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(12.8 * cm, 24.0 * cm, marginAll: 1.0 * cm),
        build: (pw.Context context) {
          return pw.ConstrainedBox(
              constraints: pw.BoxConstraints.expand(),
              child: pw.Column(children: [
                // pw.Image.asset(),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "ଆଶାୟୀ ପ୍ରାର୍ଥୀ",
                      style: pw.TextStyle(
                        font: controller.ttf,
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "ପ୍ରଶାନ୍ତ ସିଂଦେଓ",
                      style: pw.TextStyle(font: controller.ttf, fontSize: controller.fontSize),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "ଭୋଟ ଦେଇ ଜୟଯୁକ୍ତ କରାନ୍ତୁ",
                      style: pw.TextStyle(font: controller.ttf, fontSize: controller.fontSize),
                    ),
                  ],
                ),
                pw.SizedBox(
                    height: Get.height * 0.15,
                    child: pw.Image(
                      pw.MemoryImage(controller.byteList!),
                    )),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "ଆଳି ବିଧାନସଭା ନର୍ବାଚନମଣ୍ଡଳୀ ୨୦୨୪",
                      style: pw.TextStyle(font: controller.ttf, fontSize: controller.fontSize),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "ବୁଥ୍ ନଂ: ",
                      style: pw.TextStyle(font: controller.ttf, fontSize: controller.fontSize),
                    ),
                    pw.Text("20"),
                  ],
                ),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "କ୍ରମିକ ନଂ: ",
                      style: pw.TextStyle(font: controller.ttf, fontSize: controller.fontSize),
                    ),
                    pw.Text(
                      "120",
                      // style: pw.TextStyle(font: controller.ttf),
                    ),
                  ],
                ),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "ନାମ: ",
                      style: pw.TextStyle(font: controller.ttf, fontSize: controller.fontSize),
                    ),
                    pw.Text(
                      "ଜଟିନ୍ କୁମାର ସାହୁ",
                      style: pw.TextStyle(font: controller.ttf, fontSize: controller.fontSize),
                    ),
                  ],
                ),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "ମତଦାନ କେନ୍ଦ୍ର: ",
                      style: pw.TextStyle(font: controller.ttf, fontSize: controller.fontSize),
                    ),
                    pw.Text("Korua"),
                  ],
                ),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "ମତଦାନ ତାରିଖ: ",
                      style: pw.TextStyle(font: controller.ttf, fontSize: controller.fontSize),
                    ),
                    pw.Text("01/06/2024"),
                  ],
                ),
              ]));
        },
      ),
    );

    // Build and return the final Pdf file data
    return await doc.save();
  }

  Future<Uint8List> buildPdf1(PdfPageFormat format, UserDetailsModel userData) async {
    // Create the Pdf document
    MyWidgets.showLoading3();
    Completer<Uint8List> completer = Completer<Uint8List>();
    double inch = 72.0;
    double cm = inch / 2.54;
    final pw.Document doc = pw.Document();

    // Add one page with centered text "Hello World"

    controller.screenshotController
        .captureFromWidget(Column(children: [
      // pw.Image.asset(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ଆଶାୟୀ ପ୍ରାର୍ଥୀ",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.userName ?? "",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ଭୋଟ ଦେଇ ଜୟଯୁକ୍ତ କରାନ୍ତୁ",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(height: Get.height * 0.15, child: Image.asset("assets/images/bjp.png")),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ଆଳି ବିଧାନସଭା ନର୍ବାଚନମଣ୍ଡଳୀ ୨୦୨୪",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ବୁଥ୍ ନଂ: ",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            userData.boothNo ?? "",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "କ୍ରମିକ ନଂ: ",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            userData.serialNo ?? "",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
            // style: pw.TextStyle(font: controller.ttf),
          ),
        ],
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ନାମ: ",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            userData.voterName ?? "",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ଭୋଟର ଇଡି: ",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            userData.voter_id ?? "",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ମତଦାନ କେନ୍ଦ୍ର: ",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            userData.constituencyName ?? "",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ମତଦାନ ତାରିଖ: ",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            controller.electionDate ?? "",
            style: TextStyle(
                fontSize: controller.fontSize, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ]))
        .then((capturedImage) async {
      // print(">>>>>>>>>>>>data ${capturedImage}");
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat(12.8 * cm, 24.0 * cm, marginAll: 1.0 * cm),
          build: (pw.Context context) {
            return pw.ConstrainedBox(
              constraints: pw.BoxConstraints.expand(),
              child: pw.SizedBox(
                  height: Get.height * 0.15,
                  child: pw.Image(
                    pw.MemoryImage(capturedImage),
                  )),
            );
          },
        ),
      );
      completer.complete(await doc.save());
      // Handle captured image
    });

    Get.back();

    // Build and return the final Pdf file data
    // return await doc.save();
    return completer.future;
  }
}
