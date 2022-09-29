import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

class ToastManager {

  static void toastError(String msg){
    _showToast(msg, backgroundColor: ColorManager.error);
  }

  static void toastOk(String msg){
    _showToast(msg, backgroundColor: ColorManager.lightGrey);
  }

  static void _showToast(String msg, {Color? backgroundColor}){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: ColorManager.white,
        fontSize: FontSizeManager.s14
    );
  }
}