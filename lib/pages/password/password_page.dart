import 'package:flutter/material.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/pages/password/password_bloc.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/widgets/back_button.dart';
import 'package:flutter_monster/widgets/button.dart';
import 'package:flutter_monster/widgets/monster_scaffold.dart';
import 'package:flutter_monster/widgets/text_field.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/utils/utils.dart';
import 'package:flutter_monster/utils/toast.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class PasswordPage extends StatelessWidget {
    const PasswordPage(
        {this.account, this.verifyCode, this.verifyCodeToken, this.isRegister, Key key})
        : super(key: key);

    final String verifyCode;
    final String account;
    final String verifyCodeToken;
    final bool isRegister;

    @override
    Widget build(BuildContext context) {
        final PasswordBloc bloc = BlocProvider.of<PasswordBloc>(context);

        return MonsterScaffold(
            leftButton: MBackButton(),
            title: S
                .of(context)
                .setPassword,
            child: Column(
                children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                                Gaps.vGap10,
                                _buildMTextField(context, bloc),
                                Gaps.vGap50,
                            ],
                        ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                                _buildRegisterButton(context, bloc)],
                        ),
                    )
                ],
            ),
        );
    }

    Widget _buildMTextField(BuildContext context, PasswordBloc bloc) {
        return StreamBuilder<bool>(
            stream: bloc.outIsHidden,
            initialData: true,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return MTextField(
                    icon: Icons.lock_outline,
                    hint: S
                        .of(context)
                        .password,
                    sink: bloc.getPassword,
                    obscure: snapshot.data,
                    suffix: IconButton(
                        icon: snapshot.data
                            ? (Image.asset(
                            Utils.image('eye'),
                            width: Dimens.width_third_logo,
                            height: Dimens.height_third_logo,
                            color: MColor.text_gray,
                        ))
                            : Icon(Icons.remove_red_eye),
                        onPressed: () {
                            bloc.getHidden.add('');
                        }));
            });
    }

    Widget _buildRegisterButton(BuildContext context, PasswordBloc bloc) {
        return StreamBuilder<bool>(
            stream: bloc.outIsAvailable,
            initialData: true,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return MButton(
                    text: S
                        .of(context)
                        .save,
                    onPressed: snapshot.data
                        ? null
                        : () {
                        bloc
                            .registerOrResetPassword(account, verifyCode, verifyCodeToken, isRegister)
                            .then((result) { /// 通过验证码注册
                                bloc.login(account).then((result){ ///注册成功自动登录
                                    MonstorNavigator.gotoProjectsList(context);///作品列表页
                                }).catchError((error) {
                                    Toast.show(S.of(context).LoginError);
                                });
                        }).catchError((error) {
                            print('error====>${error.response.toString()}');
                            Toast.show(S.of(context).registerError);
                        });
                    },
                );
            });
    }
}
