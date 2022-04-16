#import "OpencvpluginPlugin.h"
#if __has_include(<opencvplugin/opencvplugin-Swift.h>)
#import <opencvplugin/opencvplugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "opencvplugin-Swift.h"
#endif

@implementation OpencvpluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOpencvpluginPlugin registerWithRegistrar:registrar];
}
@end
