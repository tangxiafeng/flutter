import 'package:flutter/material.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/pages/profile/profile_bloc.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/utils/utils.dart';
import 'package:flutter_monster/widgets/avatar_image.dart';
import 'package:flutter_monster/widgets/back_button.dart';
import 'package:flutter_monster/widgets/button.dart';
import 'package:flutter_monster/widgets/monster_scaffold.dart';
import 'package:flutter_monster/widgets/text_field.dart';

class ProfilePage extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        final ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);

        return MonsterScaffold(
            leftButton: MBackButton(),
            title: S.of(context).profile,
            child: Column(
                children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                AvatarImage(
                                    width: Dimens.width_profile_avatar,
                                    height: Dimens.height_profile_avatar),
                                Gaps.vGap10,
                                Text(
                                    LocalStorage.getString(Constants.KEY_NICKNAME),
                                    style: TextStyles.mainBlackContent,
                                ),
                                Gaps.vGap30,
                                MTextField(
                                    controller: TextEditingController.fromValue(
                                        TextEditingValue(
                                            text: bloc.getAccount(),
                                        )),
                                    enabled: false,
                                    decoration: InputDecoration(
                                        prefix: Text(
                                            Utils.isEmailAccount() ?
                                            S.of(context).preEmail : S.of(context).prePhone,
                                            style: TextStyles.hintContent,
                                        ),
                                        border: InputBorder.none,
                                    )),
                                Container(
                                    width: Dimens.width_text_field,
                                    child: Row(
                                        children: <Widget>[
                                            Expanded(
                                                flex: 1,
                                                child: MTextField(
                                                    controller: TextEditingController.fromValue(
                                                        TextEditingValue(
                                                            text: bloc.getPassword(),
                                                        )),
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                        prefix: Text(
                                                            S.of(context).prePassword,
                                                            style: TextStyles.hintContent,
                                                        ),
                                                        border: InputBorder.none,
                                                    ),
                                                    obscure: true,
                                                ),
                                            ),
                                            Expanded(
                                                flex: 0,
                                                child: FlatButton(
                                                    onPressed: () {
                                                        MonstorNavigator.gotoChangePwd(context);
                                                    },
                                                    child: Text(
                                                        S.of(context).change,
                                                        style: TextStyles.flatButtonContent,
                                                    )),
                                            )
                                        ],
                                    )),
                            ],
                        )),
                    Expanded(
                        flex: 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                                MButton(
                                    text: S.of(context).logout,
                                    color: Colors.red,
                                    onPressed: () {
                                        bloc.clearStorage();
                                        MonstorNavigator.gotoWelcome(context);
                                    },
                                )
                            ],
                        ),
                    )
                ],
            )
        );
    }

}