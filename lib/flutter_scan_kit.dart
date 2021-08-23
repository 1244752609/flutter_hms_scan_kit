import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_scan_kit/scan_result.dart';

class FlutterScanKit {
  static const MethodChannel _channel = const MethodChannel('flutter_scan_kit');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///扫码
  static Future<ScanResult?> get scan async {
    var result = await _channel.invokeMethod('startScan') as Map;
    final scanType = result['scanType'] as int;
    final scanTypeForm = result['scanTypeForm'] as int;
    final value =
        result['valueByte'] != null ? result['value'] as String : null;
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
    return scanResult;
  }

  ///生产条码
  static Future<List<int>?> generateCode({
    String content = "", //内容
    ScanType type = ScanType.QRCODE_SCAN_TYPE, //码类型 ScanType
    int width = 500, //宽
    int height = 500, //高
    String color = "#000000", //码颜色
    Uint8List? logo, //logo
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
    var result = await _channel.invokeMethod('generateCode', map) as Map;
    final code = result['code'] as List<int>;
    return code;
  }
}
