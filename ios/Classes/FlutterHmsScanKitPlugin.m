#import "FlutterHmsScanKitPlugin.h"
#if __has_include(<flutter_hms_scan_kit/flutter_hms_scan_kit-Swift.h>)
#import <flutter_hms_scan_kit/flutter_hms_scan_kit-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_hms_scan_kit-Swift.h"
#endif

@implementation FlutterHmsScanKitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterHmsScanKitPlugin registerWithRegistrar:registrar];
}
@end
