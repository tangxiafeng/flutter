import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/utils/utils.dart';
import 'package:flutter_monster/widgets/button.dart';
import 'package:flutter_monster/widgets/flat_button.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class Welcome extends StatelessWidget {
    const Welcome({
        Key key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Image.asset(
                        Utils.image('logo'),
                        width: Dimens.width_logo,
                        height: Dimens.height_logo,
                    ),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                            MButton(
                                text: S.of(context).login,
                                onPressed: () {
                                    MonstorNavigator.gotoLogin(context);
                                },
                            ),
                            MFlatButton(
                                text: S.of(context).register,
                                onPressed: () {
                                    MonstorNavigator.gotoChangeRegister(context);
                                },
                            )
                        ],
                    ),
                ),
            ],
        );
    }
}