import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../CommonModel/DropDownValue.dart';
import '../CommonModel/KeyvalueModel.dart';
import '../data/SizeDefine.dart';
import '../data/app_data.dart';
import 'CustomSearchDropDown/src/popupMenu.dart';



class DropDown{
  static KeyvalueModel? selectedKey;
  static KeyvalueModel? selectedKey1;
  static staticDropdown(
      String label, String callFrom, List<KeyvalueModel> list, Function fun) {
    return (DropdownSearch<KeyvalueModel>(
      popupProps: PopupProps.modalBottomSheet (
        showSelectedItems: false,
        showSearchBox: true,


        searchFieldProps: TextFieldProps(decoration: InputDecoration(

          fillColor: Colors.grey,
          hintText: 'Search Here',
          hintStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.all(5.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey,width: 1.0),),
        ),
        ),

      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        //dropdownSearchDecoration: InputDecoration(border: InputBorder.underline),
          dropdownSearchDecoration: InputDecoration(
            hintText: label,
            // hintStyle: TextStyle(color: Colors.black,fontSize: 12),
            contentPadding: EdgeInsets.only(left: 4,top: 4,bottom: 14,right: 4),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Theme.of(Get.context!).disabledColor),
          ),
          textAlignVertical:TextAlignVertical.center
      ),

      //items: maritalStatus,
      selectedItem: getData(callFrom),
      items: list,

      onChanged: (KeyvalueModel? data) {
        fun(data);
        switch (callFrom) {
          case "district":
            selectedKey = data;
            break;
        }
        //selectbank = data;
      },
    ));
  }

  static KeyvalueModel? getData(String callFor) {
    switch (callFor) {
      case "block":
        return selectedKey1;
        break;
 /*     case "expenseHead":
        return ManageExpense.expenseHead;*/
        break;

    // vencounrty,venstate,venstate
    }
  }


  static networkDropdownGetpart(
      String label, final String API, String callFrom, Function fun,IconData icons) {
    WidgetsFlutterBinding.ensureInitialized();

    return DropdownSearch<KeyvalueModel>(
      popupProps: const PopupProps.modalBottomSheet(
        showSelectedItems: false,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(decoration: InputDecoration(
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(8.0),
          //   //borderSide: BorderSide(color: Colors.blueGrey,width: 1.0),
          //
          //   //gapPadding: 20.0,
          //
          // ),

          //     labelStyle: TextStyle(
          //   color: Colors.blueGrey,
          // ),

          fillColor: Colors.grey,
          hintText: 'Search Here',
          hintStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.all(5.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey,width: 1.0),),
        ),
        ),


      ),

      dropdownDecoratorProps: DropDownDecoratorProps(
        //dropdownSearchDecoration: InputDecoration(border: InputBorder.underline),
          dropdownSearchDecoration: InputDecoration(
            hintText: label,
           fillColor: Colors.white,
           filled: true,
           /* hintStyle: TextStyle(color: Colors.black,fontSize: 12),*/
              contentPadding: EdgeInsets.only(left: 0, top: 15, right: 4, bottom: 0),

            border:OutlineInputBorder(
              borderSide:
              BorderSide(width: 0, color: Colors.white), //<-- SEE HERE
              borderRadius: BorderRadius.circular(50.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(width: 0, color: Colors.white), //<-- SEE HERE
              borderRadius: BorderRadius.circular(50.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(width: 0, color: Colors.white), //<-- SEE HERE
              borderRadius: BorderRadius.circular(50.0),
            ) ,
            prefixIcon: Icon(icons, color: Colors.black),
            hintStyle: TextStyle(
              color: AppData.hinttextcolor, // <-- Change this
              fontSize: AppData.hinttextSize,
              // fontWeight: FontWeight.w400,
              // fontStyle: FontStyle.normal,
            ),
            // labelText: hint,
            labelStyle: TextStyle(
              color: AppData.lebletextcolor, // <-- Change this
              fontSize: AppData.lebletextSize,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),


          ),
          textAlignVertical:TextAlignVertical.center,
      ),

      selectedItem: getData(callFrom),


      asyncItems: (String filter) async {
        var response = await Dio().get(
          API,
        );
        var list;
        switch (callFrom) {
          case "city":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "skill":
            list = KeyvalueModel.fromJsonList(response.data["skill_arr"]);
            break;
          case "class":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
        }

        // serveType,itemSubCategory,itemCategory

        return list;
      },
      onChanged: (KeyvalueModel? data) {
        fun(data);
      },
    );
  }

  static networkDropdownGetpartStu(
      String label, final String API, String callFrom, Function fun,IconData icons) {
    WidgetsFlutterBinding.ensureInitialized();

    return DropdownSearch<KeyvalueModel>(
      popupProps: const PopupProps.modalBottomSheet(
        showSelectedItems: false,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(decoration: InputDecoration(
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(8.0),
          //   //borderSide: BorderSide(color: Colors.blueGrey,width: 1.0),
          //
          //   //gapPadding: 20.0,
          //
          // ),

          //     labelStyle: TextStyle(
          //   color: Colors.blueGrey,
          // ),

          fillColor: Colors.grey,
          hintText: 'Search Here',
          hintStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.only(left: 0, top: 4, right: 4),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey,width: 1.0),),
        ),
        ),


      ),

      dropdownDecoratorProps: DropDownDecoratorProps(
        //dropdownSearchDecoration: InputDecoration(border: InputBorder.underline),
        dropdownSearchDecoration: InputDecoration(
          hintText: label,
       /*   fillColor: Colors.white,
          filled: true,*/
          /* hintStyle: TextStyle(color: Colors.black,fontSize: 12),*/
          contentPadding: EdgeInsets.only(left: 0, top: 15, right: 4, bottom: 0),

          border:UnderlineInputBorder(
            borderSide:
            BorderSide(width: 0, color: Colors.black), //<-- SEE HERE
            borderRadius: BorderRadius.circular(1.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(width: 0, color: Colors.black), //<-- SEE HERE
            borderRadius: BorderRadius.circular(1.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(width: 0, color: Colors.black), //<-- SEE HERE
            borderRadius: BorderRadius.circular(1.0),
          ) ,
          // prefixIcon: Icon(icons, color: Colors.black),
          hintStyle: TextStyle(
            color: AppData.hinttextcolor, // <-- Change this
            fontSize: AppData.hinttextSize,
            // fontWeight: FontWeight.w400,
            // fontStyle: FontStyle.normal,
          ),
          // labelText: hint,
          labelStyle: TextStyle(
            color: AppData.lebletextcolor, // <-- Change this
            fontSize: AppData.lebletextSize,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),


        ),
        textAlignVertical:TextAlignVertical.center,
      ),

      selectedItem: getData(callFrom),


      asyncItems: (String filter) async {
        var response = await Dio().get(
          API,
        );
        var list;
        switch (callFrom) {
          case "city":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "skill":
            list = KeyvalueModel.fromJsonList(response.data["skill_arr"]);
            break;
          case "class":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "classStu":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
        }

        // serveType,itemSubCategory,itemCategory

        return list;
      },
      onChanged: (KeyvalueModel? data) {
        fun(data);
      },
    );
  }

  static Widget formDropDown1WidthMap(
      List<DropDownValue>? items,
      Function(DropDownValue) callback,
      String hint,
      double widthRatio, {
        double? height,
        bool showMenuInbottom = true,
        double? paddingBottom,
        DropDownValue? selected,
        bool? isEnable,
        String? Function(DropDownValue? value)? validator,
        bool? searchReq,
        bool autoFocus = false,
        bool? showSearchField = true,
        double dialogHeight = 350,
        void Function(bool)? onFocusChange,
        double? dialogWidth,
        FocusNode? inkWellFocusNode,
        GlobalKey? widgetKey,
        bool showtitle = true,
        bool titleInLeft = false,
        bool? isMandatory = false,
        Function(bool dropDownOpen)? dropdownOpen,
      }) {
    isEnable ??= true;
    widgetKey ??= GlobalKey();
    final textColor = (isEnable) ? Colors.black : Colors.grey;
    final iconLineColor = (isEnable) ? Colors.deepPurpleAccent : Colors.grey;
    inkWellFocusNode ??= FocusNode();
    final _scrollController = ScrollController();
    return Column(
      // key: titleInLeft ? null : widgetKey,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showtitle && !titleInLeft) ...{
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: hint ?? "",
                style: TextStyle(
                  fontSize: SizeDefine.labelSize1,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: (isMandatory ?? false) ? " *" : "",
                style: TextStyle(
                  fontSize: SizeDefine.labelSize1,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          const SizedBox(height: 5),
        },
        StatefulBuilder(builder: (context, re) {
          bool showNoRecord = false;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (titleInLeft) ...{
                Text(
                  hint,
                  style: TextStyle(
                    fontSize: SizeDefine.labelSize1,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 10),
              },
              InkWell(
                // key: widgetKey,
                // key: titleInLeft ? widgetKey : null,
                  autofocus: autoFocus,
                  focusNode: inkWellFocusNode,
                  canRequestFocus: (isEnable ?? true),
                  onFocusChange: onFocusChange,
                  onTap: (!isEnable!)
                      ? null
                      : () {
                    if (dropdownOpen != null) {
                      dropdownOpen(true);
                    }
                    var isLoading = RxBool(false);

                    final RenderBox renderBox = widgetKey!.currentContext
                        ?.findRenderObject() as RenderBox;
                    final offset = renderBox.localToGlobal(Offset.zero);
                    final left = offset.dx;
                    final top = (offset.dy + renderBox.size.height);
                    final right = left + renderBox.size.width;
                    final width = renderBox.size.width;
                    if ((items == null || items.isEmpty)) {
                      showMenu(
                          context: context,
                          useRootNavigator: true,
                          position: RelativeRect.fromLTRB(
                              left, top, right, 0.0),
                          constraints: BoxConstraints.expand(
                            width: dialogWidth ?? width,
                            height: 120,
                          ),
                          items: [
                            PopupMenuItem(
                              child: Text(
                                "No Record Found",
                                style: TextStyle(
                                  fontSize:
                                  SizeDefine.dropDownFontSize - 1,
                                ),
                              ),
                            )
                          ]).then((value) {
                        if (dropdownOpen != null) {
                          dropdownOpen(false);
                        }
                      });
                    }
                    else {
                      var tempList = RxList<DropDownValue>([]);
                      // if (selected == null) {
                      //   tempList.addAll(items);
                      // } else {
                      for (var i = 0; i < items.length; i++) {
                        tempList.add(items[i]);
                      }
                      // }
                      showMenu(
                        context: context,
                        useRootNavigator: true,
                        position:
                        RelativeRect.fromLTRB(left, top, right, 0.0),
                        constraints: BoxConstraints.expand(
                          width: dialogWidth ?? width,
                          height: dialogHeight,
                        ),
                        items: [
                          CustomPopupMenuItem(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: SizeDefine.fontSizeInputField),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: dialogHeight - 20,
                              child: Column(
                                children: [
                                  /// search
                                  if (showSearchField ?? true)
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          contentPadding:
                                          EdgeInsets.all(12),
                                          isDense: true,
                                          isCollapsed: true,
                                          hintText: "Search",
                                          counterText: ""),
                                      controller: TextEditingController(),
                                      autofocus: true,
                                      style: TextStyle(
                                        fontSize:
                                        SizeDefine.fontSizeInputField,
                                      ),
                                      onChanged: ((value) {
                                        if (value.isNotEmpty) {
                                          tempList.clear();
                                          for (var i = 0;
                                          i < items.length;
                                          i++) {
                                            if (items[i]
                                                .value!
                                                .toLowerCase()
                                                .contains(value
                                                .toLowerCase())) {
                                              tempList.add(items[i]);
                                            }
                                          }
                                        } else {
                                          tempList.clear();
                                          tempList.addAll(items);
                                          tempList.refresh();
                                        }
                                      }),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            "  "),
                                      ],
                                      maxLength: SizeDefine.maxcharlimit,
                                    ),

                                  /// progreesbar
                                  Obx(() {
                                    return Visibility(
                                      visible: isLoading.value,
                                      child:
                                      const LinearProgressIndicator(
                                        minHeight: 3,
                                      ),
                                    );
                                  }),

                                  const SizedBox(height: 5),

                                  /// list
                                  Expanded(
                                    child: Obx(
                                          () {
                                        return Scrollbar(
                                          // isAlwaysShown: true,
                                          controller: _scrollController,
                                          child: ListView(
                                            controller: _scrollController,
                                            shrinkWrap: true,
                                            children: tempList
                                                .map(
                                                  (element) => InkWell(
                                                onTap: () {
                                                  Navigator.pop(
                                                      context);
                                                  selected = element;
                                                  re(() {});
                                                  callback(element);
                                                  FocusScope.of(
                                                      context)
                                                      .requestFocus(
                                                      inkWellFocusNode);
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical:
                                                      8),
                                                  child: Text(
                                                    element.value ??
                                                        "null",
                                                    style: TextStyle(
                                                      fontSize: SizeDefine
                                                          .dropDownFontSize -
                                                          1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                                .toList(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ).then((value) {
                        if (dropdownOpen != null) {
                          dropdownOpen(false);
                        }
                      });
                    }
                  },
                  child: Container(
                    key: widgetKey,
                    width: Get.width * widthRatio,
                    height: SizeDefine.heightInputField,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: iconLineColor,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8, right: 4),
                                child: Text(
                                  (selected?.value ??
                                      (items!.isEmpty && showNoRecord
                                          ? "NO Record Found"
                                          : "")),
                                  style: TextStyle(
                                    fontSize: SizeDefine.fontSizeInputField,
                                    color: textColor,
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            )),
                        Icon(
                          Icons.arrow_drop_down,
                          color: iconLineColor,
                        )
                      ],
                    ),
                  )),
            ],
          );
        }),
      ],
    );
  }

  static Widget formDropDown1WidthMap1(
      List<DropDownValue>? items,
      Function(DropDownValue) callback,
      String hint,
      double widthRatio, {
        double? height,
        bool showMenuInbottom = true,
        double? paddingBottom,
        DropDownValue? selected,
        bool? isEnable,
        String? Function(DropDownValue? value)? validator,
        bool? searchReq,
        bool autoFocus = false,
        bool? showSearchField = true,
        double dialogHeight = 350,
        double titleWidth = 30,
        void Function(bool)? onFocusChange,
        double? dialogWidth,
        FocusNode? inkWellFocusNode,
        GlobalKey? widgetKey,
        bool showtitle = true,
        bool titleInLeft = false,
        bool? isMandatory = false,
        Function(bool dropDownOpen)? dropdownOpen,
      }) {
    isEnable ??= true;
    widgetKey ??= GlobalKey();
    final textColor = (isEnable) ? Colors.black : Colors.grey;
    final iconLineColor = (isEnable) ? Colors.deepPurpleAccent : Colors.grey;
    inkWellFocusNode ??= FocusNode();
    final _scrollController = ScrollController();
    return Column(
      // key: titleInLeft ? null : widgetKey,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showtitle && !titleInLeft) ...{
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: hint ?? "",
                style: TextStyle(
                  fontSize: SizeDefine.labelSize1,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: (isMandatory ?? false) ? " *" : "",
                style: TextStyle(
                  fontSize: SizeDefine.labelSize1,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          const SizedBox(height: 5),
        },
        StatefulBuilder(builder: (context, re) {
          bool showNoRecord = false;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (titleInLeft) ...{

                SizedBox(
                  width:titleWidth??30,
                  child:Text(
                    hint,
                    style: TextStyle(
                      fontSize: SizeDefine.labelSize1,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              },
              InkWell(
                // key: widgetKey,
                // key: titleInLeft ? widgetKey : null,
                  autofocus: autoFocus,
                  focusNode: inkWellFocusNode,
                  canRequestFocus: (isEnable ?? true),
                  onFocusChange: onFocusChange,
                  onTap: (!isEnable!)
                      ? null
                      : () {
                    if (dropdownOpen != null) {
                      dropdownOpen(true);
                    }
                    var isLoading = RxBool(false);

                    final RenderBox renderBox = widgetKey!.currentContext
                        ?.findRenderObject() as RenderBox;
                    final offset = renderBox.localToGlobal(Offset.zero);
                    final left = offset.dx;
                    final top = (offset.dy + renderBox.size.height);
                    final right = left + renderBox.size.width;
                    final width = renderBox.size.width;
                    if ((items == null || items.isEmpty)) {
                      showMenu(
                          context: context,
                          useRootNavigator: true,
                          position: RelativeRect.fromLTRB(
                              left, top, right, 0.0),
                          constraints: BoxConstraints.expand(
                            width: dialogWidth ?? width,
                            height: 120,
                          ),
                          items: [
                            PopupMenuItem(
                              child: Text(
                                "No Record Found",
                                style: TextStyle(
                                  fontSize:
                                  SizeDefine.dropDownFontSize - 1,
                                ),
                              ),
                            )
                          ]).then((value) {
                        if (dropdownOpen != null) {
                          dropdownOpen(false);
                        }
                      });
                    } else {
                      var tempList = RxList<DropDownValue>([]);
                      // if (selected == null) {
                      //   tempList.addAll(items);
                      // } else {
                      for (var i = 0; i < items.length; i++) {
                        tempList.add(items[i]);
                      }
                      // }
                      showMenu(
                        context: context,
                        useRootNavigator: true,
                        position:
                        RelativeRect.fromLTRB(left, top, right, 0.0),
                        constraints: BoxConstraints.expand(
                          width: dialogWidth ?? width,
                          height: dialogHeight,
                        ),
                        items: [
                          CustomPopupMenuItem(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: SizeDefine.fontSizeInputField),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: dialogHeight - 20,
                              child: Column(
                                children: [
                                  /// search
                                  if (showSearchField ?? true)
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          contentPadding:
                                          EdgeInsets.all(12),
                                          isDense: true,
                                          isCollapsed: true,
                                          hintText: "Search",
                                          counterText: ""),
                                      controller: TextEditingController(),
                                      autofocus: true,
                                      style: TextStyle(
                                        fontSize:
                                        SizeDefine.fontSizeInputField,
                                      ),
                                      onChanged: ((value) {
                                        if (value.isNotEmpty) {
                                          tempList.clear();
                                          for (var i = 0;
                                          i < items.length;
                                          i++) {
                                            if (items[i]
                                                .value!
                                                .toLowerCase()
                                                .contains(value
                                                .toLowerCase())) {
                                              tempList.add(items[i]);
                                            }
                                          }
                                        } else {
                                          tempList.clear();
                                          tempList.addAll(items);
                                          tempList.refresh();
                                        }
                                      }),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            "  "),
                                      ],
                                      maxLength: SizeDefine.maxcharlimit,
                                    ),

                                  /// progreesbar
                                  Obx(() {
                                    return Visibility(
                                      visible: isLoading.value,
                                      child:
                                      const LinearProgressIndicator(
                                        minHeight: 3,
                                      ),
                                    );
                                  }),

                                  const SizedBox(height: 5),

                                  /// list
                                  Expanded(
                                    child: Obx(
                                          () {
                                        return Scrollbar(
                                          // isAlwaysShown: true,
                                          controller: _scrollController,
                                          child: ListView(
                                            controller: _scrollController,
                                            shrinkWrap: true,
                                            children: tempList
                                                .map(
                                                  (element) => InkWell(
                                                onTap: () {
                                                  Navigator.pop(
                                                      context);
                                                  selected = element;
                                                  re(() {});
                                                  callback(element);
                                                  FocusScope.of(
                                                      context)
                                                      .requestFocus(
                                                      inkWellFocusNode);
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical:
                                                      8),
                                                  child: Text(
                                                    element.value ??
                                                        "null",
                                                    style: TextStyle(
                                                      fontSize: SizeDefine
                                                          .dropDownFontSize -
                                                          1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                                .toList(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ).then((value) {
                        if (dropdownOpen != null) {
                          dropdownOpen(false);
                        }
                      });
                    }
                  },
                  child: Container(
                    key: widgetKey,
                    width: Get.width * widthRatio,
                    height: SizeDefine.heightInputField,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: iconLineColor,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8, right: 4),
                                child: Text(
                                  (selected?.value ??
                                      (items!.isEmpty && showNoRecord
                                          ? "NO Record Found"
                                          : "")),
                                  style: TextStyle(
                                    fontSize: SizeDefine.fontSizeInputField,
                                    color: textColor,
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            )),
                        Icon(
                          Icons.arrow_drop_down,
                          color: iconLineColor,
                        )
                      ],
                    ),
                  )),
            ],
          );
        }),
      ],
    );
  }


}