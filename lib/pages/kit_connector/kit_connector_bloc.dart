import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bridge_webview/flutter_bridge_webview.dart';
import 'package:flutter_monster/blocs/application_bloc.dart';
import 'package:flutter_monster/blocs/bloc_base.dart';
import 'package:flutter_monster/models/ble_device.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/log.dart';

class KitConnectorBloc implements BlocBase {

    String kit;
    bool isDisconnected;

    ApplicationBloc _appBloc;

    final BridgeWebViewController _webViewController = BridgeWebViewController();
    List<BleDevice> _scannedDevicesList = List<BleDevice>();
    List<BluetoothService> _servicesList = List<BluetoothService>();
    List<BluetoothCharacteristic> _characteristicsList = List<BluetoothCharacteristic>();

    StreamSubscription _scanController;
    BleDevice _connectedDevice;

    Timer _timer;

    void dispose() {
        if (_scannedDevicesList.length > 0) {
            _scannedDevicesList.clear();
        }
        if (_servicesList.length > 0) {
            _servicesList.clear();
        }
        if (_characteristicsList.length > 0) {
            _characteristicsList.clear();
        }
        if (_timer != null && _timer.isActive) {
            _timer.cancel();
        }
        if (_scanController != null) {
            _scanController.cancel();
        }
    }

    KitConnectorBloc(String kitName, String state, {BleDevice device}) {
        kit = kitName;
        isDisconnected = state == Constants.CONNECT_STATE_DISCONNECT;

        if (isDisconnected) {
            _webViewController.callHandler(
                'updateKit', json.encode([kit]));
            _webViewController.registerBridgeChannels(
                <BridgeChannel>[
                    _connectJsChannel(),
                    _disconnectJsChannel(),
                    _discoverServicesJsChannel(),
                    _discoverCharacteristicsJsChannel(),
                    _setNotifyJsChannel(),
                    _writeJsChannel(),
                    _readHexFileChannel(),
                    _setFlashProcess(),
                    _reportFirmataReady(),
                ].toSet());
        }
    }

    void setAppBloc(ApplicationBloc appBloc) {
        _appBloc = appBloc;
    }

    void startScan() {
        if (!isDisconnected) {
            return;
        }
        if (_scannedDevicesList.length > 0) {
            _scannedDevicesList.clear();
        }
        _scanController = FlutterBlue.instance.scan().listen((scanResult) {
            if (scanResult.device.name.isNotEmpty &&
                (scanResult.device.name.startsWith('ideaBot') ||
                    scanResult.device.name.startsWith('mCookie') ||
                    scanResult.device.name.startsWith('Microduino'))) {
                BleDevice device = BleDevice(
                    scanResult.device.name, scanResult.rssi, scanResult.device);
                _scannedDevicesList.add(device);
            }
        });

        _timer = Timer(Duration(seconds: 2), () {
            _connectedDevice = _getConnectDevice();
        });
    }

    BleDevice _getConnectDevice() {
        if (_scannedDevicesList.length > 0) {
            _timer.cancel();
            _scanController.cancel();
            _scannedDevicesList.sort((a, b) => b.rssi.compareTo(a.rssi));
            _webViewController.callHandler(
                'connectHardwareFromPad',
                json.encode([
                    kit,
                    _scannedDevicesList[0].name,
                    _scannedDevicesList[0].rssi,
                    _scannedDevicesList[0].device.id.toString()
                ]));
            return _scannedDevicesList[0];
        }
        return null;
    }

    BridgeChannel _connectJsChannel() {
        return BridgeChannel(
            name: 'onConnect',
            onBridgeHandler: (data) async {
                await _connect();
                return null;
            });
    }

    BridgeChannel _disconnectJsChannel() {
        return BridgeChannel(
            name: 'onDisconnect',
            onBridgeHandler: (data) {
                _disconnect();
                return null;
            });
    }

    BridgeChannel _discoverServicesJsChannel() {
        return BridgeChannel(
            name: 'onDiscoverServices',
            onBridgeHandler: (data) async {
                await _discoverServices(data);
                return null;
            });
    }

    BridgeChannel _discoverCharacteristicsJsChannel() {
        return BridgeChannel(
            name: 'onDiscoverCharacteristics',
            onBridgeHandler: (data) {
                _discoverCharacteristics(data);
                return Future.value(_characteristicsListToJson());
            }
        );
    }

    BridgeChannel _setNotifyJsChannel() {
        return BridgeChannel(
            name: 'onSetNotify',
            onBridgeHandler: (data) {
                _setNotify(_findCharacteristicByUuid(data));
                return null;
            }
        );
    }

    BridgeChannel _writeJsChannel() {
        return BridgeChannel(
            name: 'onWrite',
            onBridgeHandler: (data) async {
                List<String> args = List<String>.from(json.decode(data));
                List<int> list = args[1].codeUnits;
                Uint8List bytes = Uint8List.fromList(list);
                await _write(_findCharacteristicByUuid(args[0]), bytes, int.parse(args[2]));
                return null;
            }
        );
    }

    BridgeChannel _readHexFileChannel() {
        return BridgeChannel(
            name: 'onGetHexData',
            onBridgeHandler: (data) async {
                String filename = json.decode(data)[0];
                String fileData = await rootBundle.loadString('assets/dist/static/groot/hex/$filename');
                return json.encode(fileData);
            }
        );
    }

    BridgeChannel _setFlashProcess() {
        return BridgeChannel(
            name: 'onFlashProcess',
            onBridgeHandler: (data) {
                int process = json.decode(data)[0];
                Log.e('onFlashProcess ====== ' + process.toString());
                _appBloc.getFlashProcess.add(process);
                return null;
            }
        );
    }

    BridgeChannel _reportFirmataReady() {
        return BridgeChannel(
            name: 'onFirmataReady',
            onBridgeHandler: (data) {
                _appBloc.getFlashProcess.add(100);
                return null;
            }
        );
    }

    Future _connect() async {
        _appBloc.connectionController = FlutterBlue.instance.connect(_connectedDevice.device)
            .listen((state) {
                Log.e('Device [' + _connectedDevice.name + '] ' + state.toString());
                if (state == BluetoothDeviceState.disconnected) {
                    handleDisconnect();
                } else if (state == BluetoothDeviceState.connected) {
                    _handleConnect();
                }
            });
        await Future.delayed(const Duration(seconds: 4), () {});
    }

    void _disconnect() {
        _appBloc.connectionController.cancel();
    }

    Future _discoverServices(String filter) async {
        List<String> filterUUIDs = List<String>.from(json.decode(filter));
        List<BluetoothService> services = await _connectedDevice.device
            .discoverServices();
        services.forEach((service) {
            filterUUIDs.forEach((uuid) {
                String serviceUUID = service.uuid.toString();
                if (serviceUUID.contains(uuid)) {
                    _servicesList.add(service);
                }
            });
        });
    }

    void _discoverCharacteristics(String filter) {
        if (_servicesList.length > 0) {
            _servicesList.forEach((service) {
                service.characteristics.forEach((characteristic) {
                    String characteristicUUID = characteristic.uuid.toString();
                    if (_isAvailableCharacteristic(characteristicUUID, filter)) {
                        _characteristicsList.add(characteristic);
                    }
                });
            });
        }
    }

    Future _setNotify(BluetoothCharacteristic characteristic) async {
        if (characteristic != null && characteristic.properties.notify) {
            await _connectedDevice.device.setNotifyValue(characteristic, true);
            _connectedDevice.device.onValueChanged(characteristic)
                .listen((value) {
                Log.e('onValueChanged value ====== ' + value.toString());
                _webViewController.callHandler(
                        'handleNotifyData', json.encode(value));
            });
        }
    }

    Future _write(BluetoothCharacteristic characteristic, Uint8List data, int step) async {
        if (characteristic != null) {
            int start = 0;
            try {
                do {
                    Uint8List sendData = data;
                    if (data.lengthInBytes > step) {
                        int end = (data.lengthInBytes - start >= step) ?
                        start + step : data.lengthInBytes;
                        sendData = data.sublist(start, end);
                    }
                    Log.e('_write to characteristic [' + characteristic.uuid.toString() + '] sendData ====== ' + sendData.toString());
                    await _connectedDevice.device.writeCharacteristic(
                        characteristic, sendData,
                        type: CharacteristicWriteType.withResponse);
                    start += step;
                } while (start < data.lengthInBytes);
            } catch (e) {
                Log.e('_write error ====== ' + e.toString());
            }
            // TODO: Need to Optimize
            // await Future.delayed(const Duration(milliseconds: 200), () => '200ms');
        }
    }

    bool _isAvailableCharacteristic(String characteristicUUID, String filter) {
        List<String> filterUUIDs = List<String>.from(json.decode(filter));
        for (int i=0; i < filterUUIDs.length; i++) {
            String uuid = filterUUIDs[i];
            if (characteristicUUID.contains(uuid)) {
                return true;
            }
        }
        return false;
    }

    void handleDisconnect() {
        _webViewController.callHandler('disconnect', '');
    }

    void _handleConnect() {
        // notify
        _appBloc.getDisconnectState.add(false);
        _appBloc.getFlashProcess.add(0);
    }

    String _characteristicsListToJson() {
        StringBuffer sb = new StringBuffer('[');
        for (int i=0; i < _characteristicsList.length; i++) {
            BluetoothCharacteristic characteristic = _characteristicsList[i];
            List<String> properties = List<String>();
            if (characteristic.properties.write ||
                characteristic.properties.writeWithoutResponse) {
                properties.add('write');
            }
            if (characteristic.properties.read) {
                properties.add('read');
            }
            if (characteristic.properties.broadcast) {
                properties.add('broadcast');
            }
            if (characteristic.properties.notify) {
                properties.add('notify');
            }
            if (i > 0) sb.write(',');
            sb.write('{');
            sb.write('\"uuid\":\"${characteristic.uuid.toString()}\"');
            sb.write(',\"serviceUuid\":\"${characteristic.serviceUuid.toString()}\"');
            sb.write(',\"properties\":${json.encode(properties)}');
            sb.write(',\"type\":\"ble\"');
            sb.write('}');
        }
        sb.write(']');
        return sb.toString();
    }

    BluetoothCharacteristic _findCharacteristicByUuid(String uuid) {
        for (int i=0; i<_characteristicsList.length; i++) {
            String characteristicUuid = _characteristicsList[i].uuid.toString();
            if (characteristicUuid.contains(uuid)) {
                return _characteristicsList[i];
            }
        }
        return null;
    }

}