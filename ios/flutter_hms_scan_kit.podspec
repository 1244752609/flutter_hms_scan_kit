#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_hms_scan_kit.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_hms_scan_kit'
  s.version          = '1.0.2'
  s.summary          = '华为统一扫码服务'
  s.description      = <<-DESC
华为统一扫码服务
                       DESC
  s.homepage         = 'https://github.com/1244752609/flutter_hms_scan_kit'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'xiexin' => 'xiexin.xie@qq.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'ScanKitFrameWork'
  s.platform = :ios, '11.0'
  s.xcconfig = {'ENABLE_BITCODE' => 'NO'}

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # ScanKitFrameWork.framework 华为统一扫码服务
  # s.ios.vendored_frameworks = 'ScanKitFrameWork.framework'
  # s.vendored_frameworks = 'ScanKitFrameWork.framework'
end
