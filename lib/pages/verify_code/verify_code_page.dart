import 'package:flutter/material.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/pages/verify_code/verify_code_bloc.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/widgets/back_button.dart';
import 'package:flutter_monster/widgets/button.dart';
import 'package:flutter_monster/widgets/monster_scaffold.dart';
import 'package:flutter_monster/widgets/code_input_text_field.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/utils/utils.dart';
import 'package:flutter_monster/models/gee_test.dart';
import 'package:flutter_monster/utils/toast.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({this.account, this.verifyCodeToken,this.isRegister, this.gt, Key key})
      : super(key: key);

  final Gt gt;
  final String account;
  final String verifyCodeToken;
  final bool isRegister;

  @override
  Widget build(BuildContext context) {
    final VerifyCodeBloc bloc = BlocProvider.of<VerifyCodeBloc>(context);
    bloc.verifyCodeToken = verifyCodeToken;
    PinEditingController _pinEditingController = PinEditingController();
    PinDecoration _pinDecoration = UnderlineDecoration(
        textStyle: TextStyle(
          color: MColor.button_normal,
          fontSize: 14,
        ),
        color: MColor.text_gray,
        enteredColor: MColor.button_normal,
        gapSpace: 5);

    return MonsterScaffold(
      leftButton: MBackButton(),
      title: S.of(context).inputCode,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: Dimens.width_text_field,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Utils.isPhone(account)
                            ? S.of(context).SMSCodeSendToPhone(account)
                            : S.of(context).EmailCodeSendToPhone(account),
                        style: TextStyles.littleContent,
                      )
                    ],
                  ),
                ),
                Gaps.vGap30,
                Container(
                  width: Dimens.width_text_field,
                  child: PinInputTextField(
                    pinLength: 4,
                    decoration: _pinDecoration,
                    pinEditingController: _pinEditingController,
                    autoFocus: true,
                    onChanged: (pin) {
                      if (pin.length == bloc.codeLength) {
                        /// Add action to handle submit.
                        bloc.checkVerifyCode(account, pin).then((result) {
                          MonstorNavigator.gotoSetPassword(context, account, pin, bloc.verifyCodeToken, isRegister);
                        }).catchError((error) {
                          Toast.show(S.of(context).verifyErrorCode);
                        });
                      }
                    },
                  ),
                ),
                Gaps.vGap50,
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[_buildRegisterButton(context, bloc)],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context, VerifyCodeBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.outIsAvailable,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return MButton(
            text: snapshot.data
                ? S.of(context).reacquire(bloc.seconds.toString())
                : S.of(context).regain,
            onPressed: snapshot.data
                ? null
                : () {
                    bloc
                        .sendVerifyCode(
                            account, gt.challenge, gt.seccode, gt.validate)
                        .then((result) {
                      bloc.verifyCodeToken = result;
                    }).catchError((error) {
                      Toast.show(S.of(context).accountAlreadyExists);
                    });
                  },
          );
        });
  }
}
