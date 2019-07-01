import 'package:flutter_bridge_webview/flutter_bridge_webview.dart';
import 'package:flutter_monster/blocs/bloc_base.dart';
import 'dart:io';

class ProjectBloc implements BlocBase {

    String url = Platform.isIOS
        ? 'Frameworks/App.framework/flutter_assets/assets/'
        : "file:///android_asset/flutter_assets/assets/index.html";

    ProjectBloc(String id) {
        BridgeWebViewController().show();
    }

    void dispose() {}

}