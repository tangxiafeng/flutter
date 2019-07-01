import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:oktoast/oktoast.dart';

class Toast {

    static void show(String message) {
        showToast(
            '\n' + '    ' + message + '    ' + '\n',
            duration: Duration(seconds: 3),
            position: ToastPosition.top,
            backgroundColor: Colors.black.withOpacity(0.8),
            textStyle: TextStyle(fontSize: Dimens.font_sp20),
            radius: 10.0,
        );
    }

}