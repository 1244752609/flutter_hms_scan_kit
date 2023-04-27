import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Created by XieXin on 2020/4/8.
/// Toast工具类
class ToastUtils {
  ///短Toast
  static Future<bool?> showShort(
    String msg, {
    ToastGravity gravity = ToastGravity.CENTER,
    Color? backgroundColor,
    Color textColor = Colors.white,
    double fontSize = 12.0,
  }) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      backgroundColor: backgroundColor ?? Color.fromRGBO(0, 0, 0, 0.6),
      textColor: Colors.white,
      fontSize: fontSize,
    );
  }

  ///长Toast
  static Future<bool?> showLong(
    String msg, {
    ToastGravity gravity = ToastGravity.CENTER,
    Color? backgroundColor,
    Color textColor = Colors.white,
    double fontSize = 12.0,
  }) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      backgroundColor: backgroundColor ?? Color.fromRGBO(0, 0, 0, 0.6),
      textColor: Colors.white,
      fontSize: fontSize,
    );
  }

  ///自定义Toast
  static Future<bool?> showToast(
    String msg, {
    Toast toastLength = Toast.LENGTH_SHORT,
    int timeInSecForIosWeb = 1,
    ToastGravity gravity = ToastGravity.CENTER,
    Color? backgroundColor,
    Color textColor = Colors.white,
    double fontSize = 12.0,
  }) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      timeInSecForIosWeb: timeInSecForIosWeb,
      gravity: gravity,
      backgroundColor: backgroundColor ?? Color.fromRGBO(0, 0, 0, 0.6),
      textColor: Colors.white,
      fontSize: fontSize,
    );
  }

  ///取消全部Toast
  static Future<bool?> cancel() {
    return Fluttertoast.cancel();
  }
}
