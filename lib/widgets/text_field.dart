import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/styles.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class MTextField extends StatelessWidget {
    const MTextField(
        {
            this.enabled,
            this.icon,
            this.suffix,
            this.hint,
            this.obscure = false,
            this.decoration,
            this.keyboardType: TextInputType.emailAddress,
            this.sink,
            this.controller,
            Key key
        })
        : super(key: key);

    final bool enabled;
    final IconData icon;
    final Widget suffix;
    final String hint;
    final bool obscure;
    final InputDecoration decoration;
    final Sink<String> sink;
    final TextEditingController controller;
    final TextInputType keyboardType;

    @override
    Widget build(BuildContext context) {
        return Container(
            width: Dimens.width_text_field,
            child: TextField(
                style: TextStyles.hintContent,
                controller: controller,
                enabled: enabled,
                keyboardType: keyboardType,
                decoration: decoration ?? InputDecoration(
                    prefixIcon: Icon(
                        icon,
                        color: MColor.text_gray,
                    ),
                    suffixIcon: suffix,
                    hintText: hint,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: MColor.text_gray
                        )
                    ),
                ),
                obscureText: obscure,
                onChanged: (text) {
                    sink.add(text);
                },
            ),
        );
    }
}
