//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <flutter_blue/FlutterBluePlugin.h>
#import <flutter_bridge_webview/FlutterBridgeWebviewPlugin.h>
#import <gt3/Gt3Plugin.h>
#import <path_provider/PathProviderPlugin.h>
#import <permission_handler/PermissionHandlerPlugin.h>
#import <shared_preferences/SharedPreferencesPlugin.h>
#import <sharesdk/SharesdkPlugin.h>
#import <sqflite/SqflitePlugin.h>
#import <url_launcher/UrlLauncherPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterBluePlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterBluePlugin"]];
  [FlutterBridgeWebviewPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterBridgeWebviewPlugin"]];
  [Gt3Plugin registerWithRegistrar:[registry registrarForPlugin:@"Gt3Plugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
  [SharesdkPlugin registerWithRegistrar:[registry registrarForPlugin:@"SharesdkPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
  [FLTUrlLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTUrlLauncherPlugin"]];
}

@end
