import 'package:flutter/material.dart';
import 'package:posbank/presentation/base/shared.dart';
import 'package:posbank/presentation/resources/color_manager.dart';
import 'package:posbank/presentation/resources/values_manager.dart';

import '../resources/strings_manager.dart';

class OptionsNoteView extends StatefulWidget {
  const OptionsNoteView({Key? key}) : super(key: key);

  @override
  State<OptionsNoteView> createState() => _OptionsNoteViewState();
}

class _OptionsNoteViewState extends State<OptionsNoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsManager.optionsAB),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p8, vertical: AppMargin.m20),
        child: SwitchListTile(
          value: isFromLocal,
          onChanged: (v) {
            isFromLocal = v;
            setState(() {});
          },
          title: Padding(
            padding: const EdgeInsets.only(bottom: AppPadding.p8),
            child: Text(
              StringsManager.useLocal,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          subtitle: Text(StringsManager.useLocalDis),
          activeColor: ColorManager.primary,
        ),
      ),
    );
  }
}
