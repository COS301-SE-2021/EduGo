//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<qr_code_scanner/FlutterQrPlugin.h>)
#import <qr_code_scanner/FlutterQrPlugin.h>
#else
@import qr_code_scanner;
#endif

#if __has_include(<shared_preferences/FLTSharedPreferencesPlugin.h>)
#import <shared_preferences/FLTSharedPreferencesPlugin.h>
#else
@import shared_preferences;
#endif

#if __has_include(<webview_flutter/FLTWebViewFlutterPlugin.h>)
#import <webview_flutter/FLTWebViewFlutterPlugin.h>
#else
@import webview_flutter;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterQrPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterQrPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
  [FLTWebViewFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTWebViewFlutterPlugin"]];
}

@end
