import 'package:flutter/material.dart';

class ToDoStyle {
  static const fontWeight400FontSize36 =
      TextStyle(fontSize: 36, fontWeight: FontWeight.w400);
  static const fontWeight400FontSize12 =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w100);

  static const fontWeight100FontSize14 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w100);
  static const fontWeight400FontSize15 =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
  static const fontWeight600FontSize16 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static const fontWeight600FontSize24 =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
  static const titleDecoration = InputDecoration(
      border: InputBorder.none,
      hintText: "Title Goes here..",
      hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w600));
  static const newtaskDecoration = InputDecoration(
      border: InputBorder.none,
      hintText: "Add a new task",
      hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600));
}
