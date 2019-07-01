import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/utils/styles.dart';

class MCloseButton extends StatelessWidget {

    const MCloseButton(
        {
            this.ret,
            Key key
        })
        : super(key: key);

    final bool ret;

    @override
    Widget build(BuildContext context) {
        return IconButton(
            icon: Icon(
                Icons.cancel,
                color: MColor.button_normal,
                size: Dimens.width_nav_button,
            ),
            onPressed: () {
                MonstorNavigator.popPage(context, ret: ret?? false);
            });
    }
}