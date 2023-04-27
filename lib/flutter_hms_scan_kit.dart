import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_hms_scan_kit/scan_result.dart';
import 'package:flutter_hms_scan_kit/toast_utils.dart';

class FlutterHmsScanKit {
  static MethodChannel _channel = MethodChannel('com.ara.flutter_hms_scan_kit');
  static bool isClick = false;

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///扫码
  static Future<ScanResult?> get scan async {
    return startScan();
  }

  /// 扫码
  /// isContinuousClick 是否连续点击 true-是
  /// isToastDebug 是否toast 用于测试 true-是
  static Future<ScanResult?> startScan({
    bool isContinuousClick = true,
    bool isToastDebug = false,
  }) async {
    if (isContinuousClick) {
      if (isClick) return null;
      isClick = true;
      Future.delayed(Duration(milliseconds: 500), () => isClick = false);
    }
    if (isToastDebug) ToastUtils.showLong("调起原生扫码");
    Map<String, Object> map = {"isToast": isToastDebug};
    var result = await _channel.invokeMethod('startScan', map) as Map;
    final scanType = result['scanType'] as int;
    final scanTypeForm = result['scanTypeForm'] as int;
    final value = result['value'] != null ? result['value'] as String : null;
    final valueByte =
        result['valueByte'] != null ? result['valueByte'] as List<int> : null;
    print("========> scanType: $scanType");
    print("========> scanTypeForm: $scanTypeForm");
    print("========> value: $value");
    print("========> valueByte: $valueByte");
    ScanResult scanResult = ScanResult();
    scanResult.scanType = getScanType(scanType);
    scanResult.scanTypeForm = getScanTypeFormat(scanTypeForm);
    scanResult.value = value;
    scanResult.valueByte = valueByte;
    if (isToastDebug) ToastUtils.showLong("扫码成功：$value");
    return scanResult;
  }

  ///生产条码
  static Future<List<int>?> generateCode({
    String content = "", //内容
    ScanTypeFormat type = ScanTypeFormat.QRCODE_SCAN_TYPE, //码类型 ScanType
    int width = 500, //宽
    int height = 500, //高
    String color = "#000000", //码颜色
    Uint8List? logo, //logo
    bool isToastDebug = false,
  }) async {
    if (logo == null) logo = Uint8List.fromList([]);
    Map<String, Object> map = {
      "content": content,
      "type": scanType(type),
      "width": width,
      "height": height,
      "color": color,
      "logo": logo,
    };
    if (isToastDebug) ToastUtils.showLong("调起原生生产条码");
    var result = await _channel.invokeMethod('generateCode', map) as Map;
    final code = result['code'] as List<Object?>;
    final List<int> list = code.map((item) {
      return int.parse(item!.toString());
    }).toList();
    if (isToastDebug) ToastUtils.showLong("生产条码成功");
    return list;
  }
}
