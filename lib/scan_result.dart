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

ScanType getScanType(int type) {
  switch (type) {
    case 0:
      return ScanType.QRCODE_SCAN_TYPE;
    case 1:
      return ScanType.AZTEC_SCAN_TYPE;
    case 2:
      return ScanType.DATAMATRIX_SCAN_TYPE;
    case 3:
      return ScanType.PDF417_SCAN_TYPE;
    case 4:
      return ScanType.CODE39_SCAN_TYPE;
    case 5:
      return ScanType.CODE93_SCAN_TYPE;
    case 6:
      return ScanType.CODE128_SCAN_TYPE;
    case 7:
      return ScanType.EAN13_SCAN_TYPE;
    case 8:
      return ScanType.EAN8_SCAN_TYPE;
    case 9:
      return ScanType.ITF14_SCAN_TYPE;
    case 10:
      return ScanType.UPCCODE_A_SCAN_TYPE;
    case 11:
      return ScanType.UPCCODE_E_SCAN_TYPE;
    case 12:
      return ScanType.CODABAR_SCAN_TYPE;
    default:
      return ScanType.FORMAT_UNKNOWN;
  }
}

int scanType(ScanType type) {
  switch (type) {
    case ScanType.QRCODE_SCAN_TYPE:
      return 0;
    case ScanType.AZTEC_SCAN_TYPE:
      return 1;
    case ScanType.DATAMATRIX_SCAN_TYPE:
      return 2;
    case ScanType.PDF417_SCAN_TYPE:
      return 3;
    case ScanType.CODE39_SCAN_TYPE:
      return 4;
    case ScanType.CODE93_SCAN_TYPE:
      return 5;
    case ScanType.CODE128_SCAN_TYPE:
      return 6;
    case ScanType.EAN13_SCAN_TYPE:
      return 7;
    case ScanType.EAN8_SCAN_TYPE:
      return 8;
    case ScanType.ITF14_SCAN_TYPE:
      return 9;
    case ScanType.UPCCODE_A_SCAN_TYPE:
      return 10;
    case ScanType.UPCCODE_E_SCAN_TYPE:
      return 11;
    case ScanType.CODABAR_SCAN_TYPE:
      return 12;
    default:
      return 0;
  }
}

///扫码结果信息
enum ScanType {
  ///无法识别扫描条码类型。
  FORMAT_UNKNOWN, //-1
  ///扫码类型设置-扫描所有条码类型。
  ALL_SCAN_TYPE, //0
  ///QR Code条码类型。
  QRCODE_SCAN_TYPE, //0
  ///Aztec条码类型。
  AZTEC_SCAN_TYPE, //1
  ///Data Matrix条码类型。
  DATAMATRIX_SCAN_TYPE, //2
  ///PDF417条码类型。
  PDF417_SCAN_TYPE, //3
  ///Code 39条码类型。
  CODE39_SCAN_TYPE, //4
  ///Code 93条码类型。
  CODE93_SCAN_TYPE, //5
  ///Code 128条码类型。
  CODE128_SCAN_TYPE, //6
  ///EAN-13条码类型。
  EAN13_SCAN_TYPE, //7
  ///EAN-8条码类型。
  EAN8_SCAN_TYPE, //8
  ///ITF-14条码类型。
  ITF14_SCAN_TYPE, //9
  ///UPC-A条码类型。
  UPCCODE_A_SCAN_TYPE, //10
  ///UPC-E条码类型。
  UPCCODE_E_SCAN_TYPE, //11
  ///Codabar条码类型。
  CODABAR_SCAN_TYPE, //12
}

ScanTypeFormat getScanTypeFormat(int type) {
  switch (type) {
    case 1001:
      return ScanTypeFormat.ARTICLE_NUMBER_FORM;
    case 1002:
      return ScanTypeFormat.EMAIL_CONTENT_FORM;
    case 1003:
      return ScanTypeFormat.TEL_PHONE_NUMBER_FORM;
    case 1004:
      return ScanTypeFormat.PURE_TEXT_FORM;
    case 1005:
      return ScanTypeFormat.SMS_FORM;
    case 1006:
      return ScanTypeFormat.URL_FORM;
    case 1007:
      return ScanTypeFormat.WIFI_CONNECT_INFO_FORM;
    case 1008:
      return ScanTypeFormat.EVENT_INFO_FORM;
    case 1009:
      return ScanTypeFormat.CONTACT_DETAIL_FORM;
    case 10010:
      return ScanTypeFormat.DRIVER_INFO_FORM;
    case 10011:
      return ScanTypeFormat.LOCATION_COORDINATE_FORM;
    case 10012:
      return ScanTypeFormat.ISBN_NUMBER_FORM;
    case 10013:
      return ScanTypeFormat.BOOK_MARK_FORM;
    case 10014:
      return ScanTypeFormat.VEHICLE_INFO_FORM;
    default:
      return ScanTypeFormat.PURE_TEXT_FORM;
  }
}

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
