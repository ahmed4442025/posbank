import 'package:flutter/material.dart';
import 'package:posbank/presentation/resources/strings_manager.dart';
import 'package:posbank/app/app_constants.dart';
import 'dart:convert';
import 'resources/icons_manager.dart';

class TempView extends StatefulWidget {
  const TempView({Key? key}) : super(key: key);

  @override
  State<TempView> createState() => _TempViewState();
}

class _TempViewState extends State<TempView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              StringsManager.useLocalDis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "bodyLarge",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "bodySmall",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "normal normal",
            ),
            const TextField(),
            const SizedBox(
              height: 20,
            ),
            const TextField(),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              decoration:
                  InputDecoration(errorText: StringsManager.passwordError),
            ),const SizedBox(
              height: 20,
            ),
            // --------
            const Icon(IconsManager.filterList),
            const Icon(IconsManager.options),
            const Icon(IconsManager.list),
            Image.memory(base64Decode(AppConstants.image404B64))
          ],
        ),
      )),
    );
  }
}
