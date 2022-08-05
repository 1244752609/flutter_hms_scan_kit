# Flutter华为扫码

## 华为统一扫码服务

华为统一扫码服务（Scan Kit）提供便捷的条形码和二维码扫描、解析、生成能力，帮助您快速构建应用内的扫码功能。

得益于华为在计算机视觉领域能力的积累，Scan Kit可以实现远距离码或小型码的检测和自动放大，同时针对常见复杂扫码场景（如反光、暗光、污损、模糊、柱面）做了针对性识别优化，提升扫码成功率与用户体验。

Scan Kit支持Android和iOS系统集成。其中，Android系统集成Scan Kit后支持横屏扫码能力。

## 展示

<img src=".\image\scan_kit_example.jpg" width="30%" height="30%">


## 支持的设备
- Android 4.4及以上
- iOS 11.0及以上 开发中
- iOS 不支持armv7

## 扫码支持
Scan Kit支持扫描13种全球主流的码制式。如果您的应用只处理部分特定的码制式，您也可以在setFormat中指定制式以便加快扫码速度，如果不指定，则默认处理所有支持的码制式。当前支持的码制式如下，后续将持续扩充。

- 一维码：EAN-8、EAN-13、UPC-A、UPC-E、Codabar、Code 39、Code 93、Code 128、ITF-14
- 二维码：QR Code、Data Matrix、PDF417、Aztec

## 码值解析
Scan Kit可以直接返回码的原始内容，也可以针对使用特定内容格式编码的二维码/条形码进行分析并提取结构化数据，帮助开发者快速构建关联服务。已支持如下场景：联系人信息、Wi-Fi连接信息、网页、日历日程、ID卡、短信、电话、邮件、地理位置、商品条码、ISBN。

## 码生成
1. Scan Kit支持将字符串转换为一维码或二维码，目前已支持的码制式为EAN-8、EAN-13、UPC-A、UPC-E、Codabar、Code 39、Code 93、Code 128、ITF-14、QR Code、Data Matrix、PDF417、Aztec。开发者只需要提供字符串、码制式和尺寸要求即可获得相应的码图。
2. 目前iOS不支持logo二维码生成。 

## 导入
~~~
dependencies:
  flutter_hms_scan_kit: ^x.y.z
~~~

## 使用
~~~dart
import 'package:flutter_hms_scan_kit/flutter_hms_scan_kit.dart';
import 'package:flutter_hms_scan_kit/scan_result.dart';

///扫码
ScanResult? _scanResult;
Future<void> scan() async {
    _scanResult = await FlutterHmsScanKit.scan;
    setState(() {});
}

///扫码结果
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

///生成条码
Future<void> generateCode() async {
  var bytes = await rootBundle.load("assets/images/ic_logo.png");
  _code = await FlutterHmsScanKit.generateCode(
    content: "这是条码",
    type: ScanType.QRCODE_SCAN_TYPE,
    width: 300,
    height: 300,
    color: "#7CB342",
    logo: bytes.buffer.asUint8List(),
  );
  setState(() {});
}
~~~

## iOS权限配置
使用Scan Kit时，开发者需要先添加相应的权限。
- 构建相机扫码功能，需要添加“Camera Usage Description”（相机权限）。
- 构建导入图片扫码功能，需要添加“Photo Library Usage Description”（读取相册权限）。

在info.plist文件，用Source Code打开并添加如下内容：
~~~
<key>NSCameraUsageDescription</key>
<string>请允许APP访问您的相机</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>请允许APP访问您的相册</string>
~~~

## 扫码结果类型
~~~dart
///扫码结果信息
enum ScanType {
  ///无法识别扫描条码类型。
  FORMAT_UNKNOWN, //-1
  ///扫码类型设置-扫描所有条码类型。
  ALL_SCAN_TYPE, //0
  ///QR Code条码类型。
  QRCODE_SCAN_TYPE, //1
  ///Aztec条码类型。
  AZTEC_SCAN_TYPE, //2
  ///Data Matrix条码类型。
  DATAMATRIX_SCAN_TYPE, //4
  ///PDF417条码类型。
  PDF417_SCAN_TYPE, //8
  ///Code 39条码类型。
  CODE39_SCAN_TYPE, //19
  ///Code 93条码类型。
  CODE93_SCAN_TYPE, //32
  ///Code 128条码类型。
  CODE128_SCAN_TYPE, //64
  ///EAN-13条码类型。
  EAN13_SCAN_TYPE, //128
  ///EAN-8条码类型。
  EAN8_SCAN_TYPE, //256
  ///ITF-14条码类型。
  ITF14_SCAN_TYPE, //512
  ///UPC-A条码类型。
  UPCCODE_A_SCAN_TYPE, //1024
  ///UPC-E条码类型。
  UPCCODE_E_SCAN_TYPE, //2048
  ///Codabar条码类型。
  CODABAR_SCAN_TYPE, //4096
}
~~~

## 条码内容类型
~~~dart
///条码内容类型
enum ScanTypeFormat {
  ///商品条码
  ARTICLE_NUMBER_FORM, //1001
  ///邮件
  EMAIL_CONTENT_FORM, //1002
  ///电话
  TEL_PHONE_NUMBER_FORM, //1003
  ///文本
  PURE_TEXT_FORM, //1004
  ///短信
  SMS_FORM, //1005
  ///网页
  URL_FORM, //1006
  ///Wi-Fi连接信息
  WIFI_CONNECT_INFO_FORM, //1007
  ///事件
  EVENT_INFO_FORM, //1008
  ///联系人信息
  CONTACT_DETAIL_FORM, //1009
  ///设备信息
  DRIVER_INFO_FORM, //10010
  ///地理位置
  LOCATION_COORDINATE_FORM, //10011
  ///ISBN
  ISBN_NUMBER_FORM, //10012
  ///书签
  BOOK_MARK_FORM, //10013
  ///车辆信息
  VEHICLE_INFO_FORM, //10014
}
~~~

## SDK数据安全说明
Scan Kit不会收集个人数据，Android平台只会基于运营目的收集BI（Business Intelligence）数据，iOS平台不收集任何数据 。
 