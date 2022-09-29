

import 'package:flutter/material.dart';

import '../resources/values_manager.dart';
import 'elevat_custom.dart';

class UtilM {

  static SizedBox box5() =>
      const SizedBox(height: AppSize.s5, width: AppSize.s5);

  static SizedBox box10() =>
      const SizedBox(height: AppSize.s10, width: AppSize.s10);

  static SizedBox box15() =>
      const SizedBox(height: AppSize.s15, width: AppSize.s15);

  static SizedBox box20() =>
      const SizedBox(height: AppSize.s20, width: AppSize.s20);

  static Widget loading() {
    return const Center(child: Text("loading"));
  }

  static fail() => const Center(
    child: Text("failed"),
  );

  static buttonText(
      {String text = '',
        double width = 180,
        double height = 50,
        VoidCallback? onTap,
        Color? clr}) =>
      ElevateCustomBt(
        text: text,
        height: height,
        width: width,
        onTap: onTap,
        clr: clr,
      );
}