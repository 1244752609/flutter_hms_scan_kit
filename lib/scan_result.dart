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

ScanTypeFormat getScanTypeFormat(int type) {
  switch (type) {
    case 1:
      return ScanTypeFormat.QRCODE_SCAN_TYPE;
    case 2:
      return ScanTypeFormat.AZTEC_SCAN_TYPE;
    case 4:
      return ScanTypeFormat.DATAMATRIX_SCAN_TYPE;
    case 8:
      return ScanTypeFormat.PDF417_SCAN_TYPE;
    case 16:
      return ScanTypeFormat.CODE39_SCAN_TYPE;
    case 32:
      return ScanTypeFormat.CODE93_SCAN_TYPE;
    case 64:
      return ScanTypeFormat.CODE128_SCAN_TYPE;
    case 128:
      return ScanTypeFormat.EAN13_SCAN_TYPE;
    case 256:
      return ScanTypeFormat.EAN8_SCAN_TYPE;
    case 512:
      return ScanTypeFormat.ITF14_SCAN_TYPE;
    case 1024:
      return ScanTypeFormat.UPCCODE_A_SCAN_TYPE;
    case 2048:
      return ScanTypeFormat.UPCCODE_E_SCAN_TYPE;
    case 4096:
      return ScanTypeFormat.CODABAR_SCAN_TYPE;
    default:
      return ScanTypeFormat.FORMAT_UNKNOWN;
  }
}

int scanType(ScanTypeFormat type) {
  switch (type) {
    case ScanTypeFormat.QRCODE_SCAN_TYPE:
      return 0;
    case ScanTypeFormat.AZTEC_SCAN_TYPE:
      return 1;
    case ScanTypeFormat.DATAMATRIX_SCAN_TYPE:
      return 2;
    case ScanTypeFormat.PDF417_SCAN_TYPE:
      return 3;
    case ScanTypeFormat.CODE39_SCAN_TYPE:
      return 4;
    case ScanTypeFormat.CODE93_SCAN_TYPE:
      return 5;
    case ScanTypeFormat.CODE128_SCAN_TYPE:
      return 6;
    case ScanTypeFormat.EAN13_SCAN_TYPE:
      return 7;
    case ScanTypeFormat.EAN8_SCAN_TYPE:
      return 8;
    case ScanTypeFormat.ITF14_SCAN_TYPE:
      return 9;
    case ScanTypeFormat.UPCCODE_A_SCAN_TYPE:
      return 10;
    case ScanTypeFormat.UPCCODE_E_SCAN_TYPE:
      return 11;
    case ScanTypeFormat.CODABAR_SCAN_TYPE:
      return 12;
    default:
      return 0;
  }
}

///扫码结果信息
enum ScanTypeFormat {
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
  CODE39_SCAN_TYPE, //16
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

ScanType getScanType(int type) {
  switch (type) {
    case 1001:
      return ScanType.ARTICLE_NUMBER_FORM;
    case 1002:
      return ScanType.EMAIL_CONTENT_FORM;
    case 1003:
      return ScanType.TEL_PHONE_NUMBER_FORM;
    case 1004:
      return ScanType.PURE_TEXT_FORM;
    case 1005:
      return ScanType.SMS_FORM;
    case 1006:
      return ScanType.URL_FORM;
    case 1007:
      return ScanType.WIFI_CONNECT_INFO_FORM;
    case 1008:
      return ScanType.EVENT_INFO_FORM;
    case 1009:
      return ScanType.CONTACT_DETAIL_FORM;
    case 10010:
      return ScanType.DRIVER_INFO_FORM;
    case 10011:
      return ScanType.LOCATION_COORDINATE_FORM;
    case 10012:
      return ScanType.ISBN_NUMBER_FORM;
    case 10013:
      return ScanType.BOOK_MARK_FORM;
    case 10014:
      return ScanType.VEHICLE_INFO_FORM;
    default:
      return ScanType.PURE_TEXT_FORM;
  }
}

///条码内容类型
enum ScanType {
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
