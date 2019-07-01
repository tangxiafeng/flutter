import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bridge_webview/flutter_bridge_webview.dart';
import 'package:flutter_monster/blocs/bloc_base.dart';
import 'package:flutter_monster/models/ble_device.dart';
import 'package:flutter_monster/models/language.dart';
import 'package:flutter_monster/models/project.dart';
import 'package:flutter_monster/repositories/network/projects_repository.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/event_bus.dart';
import 'package:flutter_monster/utils/http_client.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:flutter_monster/utils/log.dart';
import 'package:rxdart/rxdart.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class ProjectsListBloc implements BlocBase {

    int _page = 0;
    List<Project> projectsList = List<Project>();

    BehaviorSubject<List<Project>> _loadDataController = BehaviorSubject<List<Project>>();
    Sink<List<Project>> get _getData => _loadDataController.sink;
    Stream<List<Project>> get outLoadData => _loadDataController.stream;

    BehaviorSubject<List<String>> goNextController = BehaviorSubject<List<String>>();
    Sink<List<String>> get _getKitStatus => goNextController.sink;

    BehaviorSubject<bool> alertController = BehaviorSubject<bool>();
    Sink<bool> get _getIsAlert => alertController.sink;

    List<BleDevice> _scannedDevicesList = List<BleDevice>();

    final BridgeWebViewController _webViewController = BridgeWebViewController();

    StreamSubscription _eventSubscription;
    StreamSubscription _subscription;
    BleDevice _connectedDevice;

    bool isReading = false;

    void dispose() {
        _eventSubscription.cancel();
        _loadDataController.close();
        goNextController.close();
        alertController.close();
        _webViewController.close();
        _webViewController.dispose();
    }

    ProjectsListBloc() {
        // update http
        HttpUtil().getDio().options.baseUrl = LocalStorage.getString(Constants.KEY_PROJECTS_ADDRESS);
        HttpUtil().getDio().options.headers.putIfAbsent(
            'x-login-token', () {
                return LocalStorage.getString(Constants.KEY_TOKEN);
            });
        _loadData().catchError((error) {
            Log.e('Load projects list error ==== ' + error.toString());
        });

        _eventSubscription = EventBus().register((event) {
            Language language = event.language;
            _setProjectLocale(language.languageCode + '-' + language.countryCode);
        });

        _webViewController.launch(
            'file:///android_asset/flutter_assets/assets/dist/index.html',
            bridgeChannels: <BridgeChannel>[
                _setUserTokenJsChannel(),
                _setServerTypeJsChannel(),
                _alertJsChannel(),
                _goBackJsChannel(),
                _goNextJsChannel(),
                _startScanJsChannel(),
                _stopScanJsChannel(),
                _loadScratchAssets(),
            ].toSet(),
            hidden: true
        );
    }

    Future onRefresh() {
        _page = 0;
        projectsList.clear();
        return _loadData();
    }

    Future onLoadMore() {
        _page++;
        return _loadData();
    }

    Future _loadData() async {
        if (projectsList.length == 0) {
            projectsList.add(Project(''));
        }
        List<Project> list = await ProjectsRepository().getProjects(_page);
        if (list != null && list.length > 0) {
            projectsList.addAll(list);
            _getData.add(list);
        } else {
            _page--;
            _getData.add(projectsList);
        }
    }

    Future renameProject(String id, String name) async {
        await ProjectsRepository().renameProject(id, name);
    }

    Future deleteProject(String id) async {
        await ProjectsRepository().deleteProject(id);
    }

    BridgeChannel _setUserTokenJsChannel() {
        return BridgeChannel(
            name: 'onGetUserToken',
            onBridgeHandler: (data) async {
                return _getUserToken();
            });
    }

    BridgeChannel _setServerTypeJsChannel() {
        return BridgeChannel(
            name: 'onGetServerType',
            onBridgeHandler: (data) async {
                return _getServerType();
            });
    }

    BridgeChannel _alertJsChannel() {
        return BridgeChannel(
            name: 'onAlertNotSupport',
            onBridgeHandler: (data) {
                _webViewController.hide();
                _getIsAlert.add(true);
            });
    }

    BridgeChannel _goBackJsChannel() {
        return BridgeChannel(
            name: 'onGoBack',
            onBridgeHandler: (data) {
                _webViewController.hide();
                return null;
            });
    }

    BridgeChannel _goNextJsChannel() {
        return BridgeChannel(
            name: 'onGoNext',
            onBridgeHandler: (data) {
                List<String> args = List<String>.from(json.decode(data));
                _getKitStatus.add(args);
                Future.delayed(const Duration(milliseconds: 300), () {
                    _webViewController.hide();
                });
                return null;
            }
        );
    }

    BridgeChannel _startScanJsChannel() {
        return BridgeChannel(
            name: 'onStartScan',
            onBridgeHandler: (data) {
                _startScan();
                return null;
            });
    }

    BridgeChannel _stopScanJsChannel() {
        return BridgeChannel(
            name: 'onStopScan',
            onBridgeHandler: (data) {
                _stopScan();
                return null;
            });
    }

    BridgeChannel _loadScratchAssets() {
        return BridgeChannel(
            name: 'onLoadAssets',
            onBridgeHandler: (data) async {
                final ByteData test = await rootBundle.load('assets/dist/$data');
                Uint8List list = test.buffer.asUint8List();
                return json.encode(list);
            });
    }

    String _getUserToken() {
        return json.encode(LocalStorage.getString(Constants.KEY_SERVER_USER_DATA));
    }

    String _getServerType() {
        String server = LocalStorage.getString(Constants.KEY_PROJECTS_ADDRESS);
        return server == Constants.PROJECTS_INTERNATIONAL ? 'INTL' : 'CN';
    }

    void _setProjectLocale(String local) {
        _webViewController.callHandler('setLanguage', json.encode([local]));
    }

    void loadProject(String projectId, String title) {
        if (projectId.isNotEmpty) {
            _webViewController.callHandler('loadProjectMDX', json.encode([projectId, title]));
        } else {
            _webViewController.callHandler('loadEmptyProject', json.encode([]));
        }
        Future.delayed(const Duration(milliseconds: 500), () {
            _webViewController.show();
        });
    }

    void _startScan() {
        _scannedDevicesList.clear();
        _subscription = FlutterBlue.instance.scan().listen((scanResult) {
            if (scanResult.device.name.isNotEmpty) {
                _webViewController.callHandler('discover', json.encode([
                    scanResult.device.name,
                    scanResult.rssi,
                    scanResult.device.id.toString()
                ]));
            }
        });
    }

    void _stopScan() {
        _subscription.cancel();
    }

    void showWebview() {
        _webViewController.show();
    }

    void setConnectedDevice(BleDevice device) {
        _connectedDevice = device;
    }

    BleDevice getConnectedDevice() {
        return _connectedDevice;
    }

}
