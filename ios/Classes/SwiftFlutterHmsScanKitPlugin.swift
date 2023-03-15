import Flutter
import UIKit
import ScanKitFrameWork

public class SwiftFlutterHmsScanKitPlugin: NSObject, FlutterPlugin, DefaultScanDelegate {
    private var hostViewController: UIViewController?
    private var result: FlutterResult?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_hms_scan_kit", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterHmsScanKitPlugin()

        instance.hostViewController = UIApplication.shared.delegate?.window??.rootViewController

        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.result = result
        if call.method == "getPlatformVersion" {
            result("iOS " + UIDevice.current.systemVersion)
        } else if call.method == "startScan" {//扫码
            scan(result: result)
        } else if call.method == "generateCode" {//生产条码
            let arguments = call.arguments as? [String: Any] ?? [String: Any]()
            let content: String? = arguments["content"] as? String ?? "not value"
            let type: Int? = arguments["type"] as? Int ?? 12
            let width: Int? = arguments["width"] as? Int
            let height: Int? = arguments["height"] as? Int
            let color: String? = arguments["color"] as? String
            let logo: [UInt8]? = arguments["logo"] as? [UInt8]

            generateCode(result: result, content: content, typeCode: type, width: width, height: height, color: color, logo: logo)
        }
    }

    //扫码
    private func scan(result: @escaping FlutterResult) {
        let options = HmsScanOptions(scanFormatType: UInt32(HMSScanFormatTypeCode.ALL.rawValue), photo: true)

        let hmsDefaultScanViewController = HmsDefaultScanViewController(defaultScanWithFormatType: options)

        if hmsDefaultScanViewController != nil {
            hmsDefaultScanViewController!.defaultScanDelegate = self
            hostViewController?.view.addSubview(hmsDefaultScanViewController!.view)
            hostViewController?.addChild(hmsDefaultScanViewController!)
            hostViewController?.didMove(toParent: hmsDefaultScanViewController)
        }
    }

    //生成条码
    private func generateCode(result: @escaping FlutterResult, content: String?, typeCode: Int?, width: Int?, height: Int?, color: String?, logo: [UInt8]?) {
        let size: CGSize = CGSize(width: width ?? 500, height: height ?? 500)
        var codeFormat: HMSScanFormatTypeCode
        switch typeCode {
        case 1:
            codeFormat = HMSScanFormatTypeCode.AZTEC
        case 2:
            codeFormat = HMSScanFormatTypeCode.DATA_MATRIX
        case 3:
            codeFormat = HMSScanFormatTypeCode.PDF_417
        case 4:
            codeFormat = HMSScanFormatTypeCode.CODE_39
        case 5:
            codeFormat = HMSScanFormatTypeCode.CODE_93
        case 6:
            codeFormat = HMSScanFormatTypeCode.CODE_128
        case 7:
            codeFormat = HMSScanFormatTypeCode.EAN_13
        case 8:
            codeFormat = HMSScanFormatTypeCode.EAN_8
        case 9:
            codeFormat = HMSScanFormatTypeCode.ITF
        case 10:
            codeFormat = HMSScanFormatTypeCode.UPC_A
        case 11:
            codeFormat = HMSScanFormatTypeCode.UPC_E
        case 12:
            codeFormat = HMSScanFormatTypeCode.CODABAR
        default:
            codeFormat = HMSScanFormatTypeCode.QR_CODE
        }

        do {
            let image: UIImage = try HmsMultiFormatWriter.createCode(with: content ?? "not value", size: size, codeFomart: codeFormat)
            let data = image.jpegData(compressionQuality: 1.0)
            if data != nil {
                let count = data?.count ?? 0
                var bytes: [UInt8] = [UInt8](repeating: 0, count: count)
                data?.copyBytes(to: &bytes, from: Range(NSRange(location: 0, length: count))!)
                
                result(["code": bytes])
            } else {
                print("image.jpegData is null")
            }
        } catch {
            print(error)
        }
    }
    
    public func defaultScanDelegate(forDicResult resultDic: [AnyHashable: Any]!) {
        DispatchQueue.main.async {
            let formatValue: String = String(describing: resultDic!["formatValue"]!)
            print("formatValue: \(resultDic?["formatValue"] ?? "")")
            print("formatValue: \(formatValue)")
            print("formatValue: \(self.getScanType(formatValue: formatValue))")
            print("text: \(String(describing: resultDic["text"]))")
            let parserDic: [String: String]? = resultDic["parserDic"] as? [String: String]
            print("sceneType: \(parserDic?["sceneType"] ?? "")")
            print("sceneType: \(self.getScanTypeFormat(formatValue: parserDic?["sceneType"]! ?? ""))")
            let bytes: [String]? = resultDic["rawBytes"] as? [String]
            print("rawBytes: \(bytes ?? [String]())")

            self.result?([
                "scanTypeForm": self.getScanType(formatValue: formatValue),
                "value": resultDic!["text"],
                "scanType": self.getScanTypeFormat(formatValue: parserDic?["sceneType"] ?? ""),
            ])
        }
    }

    public func defaultScanImagePickerDelegate(for image: UIImage!) {
        let options = HmsScanOptions(scanFormatType: UInt32(HMSScanFormatTypeCode.ALL.rawValue), photo: true)
        let resultDic: [AnyHashable: Any]? = HmsBitMap.bitMap(for: image, with: options)

        DispatchQueue.main.async {
            if resultDic != nil {
                let formatValue: String = String(describing: resultDic!["formatValue"]!)
                print("formatValue: \(resultDic!["formatValue"]!)")
                print("formatValue: \(self.getScanType(formatValue:formatValue))")
                print("text: \(String(describing: resultDic!["text"]))")
                let parserDic: [String: String]? = resultDic!["parserDic"] as? [String: String]
                print("sceneType: \(parserDic?["sceneType"] ?? "")")
                print("sceneType: \(self.getScanTypeFormat(formatValue: parserDic?["sceneType"] ?? ""))")
                let bytes: [String]? = resultDic!["rawBytes"] as? [String]
                print("rawBytes: \(bytes ?? [String]())")

                self.result?([
                    "scanTypeForm": self.getScanType(formatValue: formatValue),
                    "value": resultDic!["text"],
                    "scanType": self.getScanTypeFormat(formatValue: parserDic?["sceneType"] ?? ""),
                ])
            }
        }
    }

    //获取扫码类型编码
    func getScanType(formatValue: String?) -> Int {
        switch formatValue {
        case "QR_CODE":
            return 1
        case "AZTEC":
            return 2
        case "DATA_MATRIX":
            return 4
        case "PDF_417":
            return 8
        case "CODE_39":
            return 16
        case "CODE_93":
            return 32
        case "CODE_128":
            return 64
        case "EAN_13":
            return 128
        case "EAN_8":
            return 256
        case "ITF":
            return 512
        case "UPC_A":
            return 1024
        case "UPC_E":
            return 2048
        case "CODABAR":
            return 4096
        default:
            return 0
        }
    }

    //获取扫码类型编码
    func getScanTypeFormat(formatValue: String) -> Int {
        switch formatValue.uppercased() {
        case "NUMBER":
            return 1001
        case "EMAIL":
            return 1002
        case "TEL":
            return 1003
        case "TEXT":
            return 1004
        case "SMS":
            return 1005
        case "WEBSITE"://url
            return 1006
        case "WI-FI":
            return 1007
        case "EVENT":
            return 1008
        case "CONTACT":
            return 1009
        case "DRIVER":
            return 10010
        case "LOCATION":
            return 10011
        case "BOOK":
            return 10012
        case "VEHICLE":
            return 10013
        case "PURE_TEXT":
            return 10014
        default:
            return 0
        }
    }

}
