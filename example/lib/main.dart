import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hms_scan_kit/flutter_hms_scan_kit.dart';
import 'package:flutter_hms_scan_kit/scan_result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  ScanResult? _scanResult;
  List<int>? _code;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    generateCode();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await FlutterHmsScanKit.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> scan() async {
    // _scanResult = await FlutterHmsScanKit.scan;
    _scanResult = await FlutterHmsScanKit.startScan(
      isToastDebug: false,
    );
    setState(() {});
  }

  Future<void> generateCode() async {
    var bytes = await rootBundle.load("assets/images/ic_logo.png");
    _code = await FlutterHmsScanKit.generateCode(
      content: "这是条码",
      type: ScanTypeFormat.QRCODE_SCAN_TYPE,
      width: 300,
      height: 300,
      color: "#7CB342",
      logo: bytes.buffer.asUint8List(),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter华为扫码'),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('类型: ${_scanResult?.scanTypeForm}\n'),
                Text('内容类型: ${_scanResult?.scanType}\n'),
                Text('扫码内容: ${_scanResult?.value}\n'),
                ElevatedButton(
                  onPressed: scan,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Text("扫描"),
                  ),
                ),
                SizedBox(height: 50),
                Text('生成条码\n'),
                if (_code != null)
                  Image.memory(Uint8List.fromList(_code!))
                else
                  Container(height: 300, color: Colors.transparent),
                ElevatedButton(
                  onPressed: generateCode,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Text("生成条码"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
