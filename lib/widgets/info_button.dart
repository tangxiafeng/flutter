import 'package:flutter/material.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/widgets/flat_button.dart';

class MInfoButton extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return IconButton(
            icon: Icon(
                Icons.help,
                color: MColor.button_normal,
                size: Dimens.width_nav_button,
            ),
            onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => _buildInfoDialog(context),
                );
            });
    }

    Widget _buildInfoDialog(BuildContext context) {
        return AlertDialog(
            content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    _buildInfoText(context),
                ],
            ),
            actions: <Widget>[
                MFlatButton(
                    text: S.of(context).okay,
                    style: TextStyles.flatButtonContent,
                    onPressed: () {
                        MonstorNavigator.popPage(context);
                    },
                )],
        );
    }

    Widget _buildInfoText(BuildContext context) {
        return RichText(
            text: TextSpan(
                text: S.of(context).info1,
                style: TextStyles.mainBlackContent,
                children: <TextSpan>[
                    TextSpan(
                        text: S.of(context).info2,
                        style: TextStyles.mainBlackContent,
                    ),
                    TextSpan(
                        text: S.of(context).info3,
                        style: TextStyles.mainBlackContent,
                    ),
                    TextSpan(
                        text: S.of(context).info4,
                        style: TextStyles.mainBlackContent,
                    ),
                ],
            ),
        );
    }

}