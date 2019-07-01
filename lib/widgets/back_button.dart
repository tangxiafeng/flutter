import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/utils/styles.dart';

class MBackButton extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return IconButton(
            icon: Icon(
                Icons.arrow_back_ios,
                color: MColor.button_normal
            ),
            onPressed: () {
                MonstorNavigator.popPage(context);
            });
    }

}