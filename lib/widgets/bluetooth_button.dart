import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/styles.dart';

class MBluetoothButton extends StatelessWidget {

    const MBluetoothButton(
        {
            @required this.onPressed,
            Key key
        })
        : super(key: key);

    final VoidCallback onPressed;

    @override
    Widget build(BuildContext context) {
        return IconButton(
            icon: Icon(
                Icons.bluetooth_searching,
                color: MColor.button_normal,
                size: Dimens.width_nav_button,
            ),
            onPressed: onPressed,
        );
    }
}