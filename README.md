# Flutter华为扫码

## 华为统一扫码服务

华为统一扫码服务（Scan Kit）提供便捷的条形码和二维码扫描、解析、生成能力，帮助您快速构建应用内的扫码功能。

得益于华为在计算机视觉领域能力的积累，Scan Kit可以实现远距离码或小型码的检测和自动放大，同时针对常见复杂扫码场景（如反光、暗光、污损、模糊、柱面）做了针对性识别优化，提升扫码成功率与用户体验。

Scan Kit支持Android和iOS系统集成。其中，Android系统集成Scan Kit后支持横屏扫码能力。

## 展示

<img src=".\image\scan_kit_example.jpg" width="30%" height="30%">


## 支持的设备
- Android 4.4及以上
- iOS 9.0及以上 开发中

## 扫码支持
Scan Kit支持扫描13种全球主流的码制式。如果您的应用只处理部分特定的码制式，您也可以在setFormat中指定制式以便加快扫码速度，如果不指定，则默认处理所有支持的码制式。当前支持的码制式如下，后续将持续扩充。

- 一维码：EAN-8、EAN-13、UPC-A、UPC-E、Codabar、Code 39、Code 93、Code 128、ITF-14
- 二维码：QR Code、Data Matrix、PDF417、Aztec

## 码值解析
Scan Kit可以直接返回码的原始内容，也可以针对使用特定内容格式编码的二维码/条形码进行分析并提取结构化数据，帮助开发者快速构建关联服务。已支持如下场景：联系人信息、Wi-Fi连接信息、网页、日历日程、ID卡、短信、电话、邮件、地理位置、商品条码、ISBN。

## 导入
~~~
~~~

## 使用
~~~dart
import 'package:flutter_scan_kit/flutter_scan_kit.dart';
import 'package:flutter_scan_kit/scan_result.dart';

ScanResult? _scanResult;
Future<void> scan() async {
    _scanResult = await FlutterScanKit.scan;
    setState(() {});
}

class ScanResult {
  /// 扫码结果信息
  ScanType? scanType;
  /// 条码内容类型
  ScanTypeFormat? scanTypeForm;
  /// 获取条码原始的全部码值信息。只有当条码编码格式为UTF-8时才可以使用
  String? value;
  /// 非UTF-8格式的条码使用
  List<int>? valueByte;
}
~~~

