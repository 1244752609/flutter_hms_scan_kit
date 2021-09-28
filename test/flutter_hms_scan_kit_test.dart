import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hms_scan_kit/flutter_hms_scan_kit.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_hms_scan_kit');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterHmsScanKit.platformVersion, '42');
  });
}
