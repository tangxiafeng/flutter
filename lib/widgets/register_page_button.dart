import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/utils/utils.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class MRegisterPageButton extends StatelessWidget {
  const MRegisterPageButton(
      {
        this.text,
        this.setTextColor,
        @required this.onPressed,
        Key key
      })
      : super(key: key);

  final String text;
  final bool setTextColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        text,
        style: setTextColor ? TextStyles.flatButtonContent : TextStyles.blackContent,
      ),
      onPressed: onPressed,
      splashColor: MColor.button_normal
    );
  }
}
