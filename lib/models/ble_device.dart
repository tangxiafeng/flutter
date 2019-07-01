/*
 * Created by gloria on 2018/1/9.
 */

import 'package:flutter_blue/flutter_blue.dart';

class BleDevice {
    String name;
    int rssi;
    BluetoothDevice device;

    BleDevice(this.name, this.rssi, this.device);

    @override
    String toString() {
        StringBuffer sb = new StringBuffer('{');
        sb.write("\"name\":\"$name\"");
        sb.write(",\"rssi\":$rssi");
        sb.write(",\"id\":${device.id}");
        sb.write('}');
        return sb.toString();
    }
}