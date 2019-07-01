package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.pauldemarco.flutterblue.FlutterBluePlugin;
import com.microduino.flutter_js_bridge.FlutterBridgeWebviewPlugin;
import mdesigner.ios.microduino.com.gt3.Gt3Plugin;
import io.flutter.plugins.pathprovider.PathProviderPlugin;
import com.baseflow.permissionhandler.PermissionHandlerPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;
import com.yoozoo.sharesdk.SharesdkPlugin;
import com.tekartik.sqflite.SqflitePlugin;
import io.flutter.plugins.urllauncher.UrlLauncherPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlutterBluePlugin.registerWith(registry.registrarFor("com.pauldemarco.flutterblue.FlutterBluePlugin"));
    FlutterBridgeWebviewPlugin.registerWith(registry.registrarFor("com.microduino.flutter_js_bridge.FlutterBridgeWebviewPlugin"));
    Gt3Plugin.registerWith(registry.registrarFor("mdesigner.ios.microduino.com.gt3.Gt3Plugin"));
    PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
    PermissionHandlerPlugin.registerWith(registry.registrarFor("com.baseflow.permissionhandler.PermissionHandlerPlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
    SharesdkPlugin.registerWith(registry.registrarFor("com.yoozoo.sharesdk.SharesdkPlugin"));
    SqflitePlugin.registerWith(registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"));
    UrlLauncherPlugin.registerWith(registry.registrarFor("io.flutter.plugins.urllauncher.UrlLauncherPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
