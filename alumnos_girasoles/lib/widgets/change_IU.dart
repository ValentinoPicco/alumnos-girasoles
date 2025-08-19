import 'dart:io';
import 'package:flutter/material.dart';

Widget changeIU([List<Widget> children = const []]) {
  if (Platform.isAndroid || Platform.isIOS) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
}
