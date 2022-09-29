import 'package:flutter/material.dart';

class ElevateCustomBt extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final Color? clr;

  const ElevateCustomBt(
      {Key? key,
        required this.text,
        required this.width,
        required this.height,
        this.onTap,
        this.clr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(backgroundColor: clr),
          child: Text(text)),
    );
  }
}