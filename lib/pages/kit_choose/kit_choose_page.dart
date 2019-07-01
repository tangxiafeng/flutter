import 'package:flutter/material.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/pages/kit_choose/kit_choose_bloc.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/widgets/button.dart';
import 'package:flutter_monster/widgets/close_button.dart';
import 'package:flutter_monster/widgets/info_button.dart';
import 'package:flutter_monster/widgets/kit_banner.dart';
import 'package:flutter_monster/widgets/monster_scaffold.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';

class KitChoosePage extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        final KitChooseBloc bloc = BlocProvider.of<KitChooseBloc>(context);
        return StreamBuilder<String>(
            stream: bloc.outKitName,
            builder:(BuildContext context, AsyncSnapshot<String> snapshot) {
                String kitName = snapshot.data ?? bloc.kit;

                return MonsterScaffold(
                    leftButton: MInfoButton(),
                    titleWidget: Text(
                        kitName,
                        style: TextStyles.titleContent),
                    rightButton: MCloseButton(),
                    child: Container(
                        padding: EdgeInsets.fromLTRB(
                            Dimens.gap_dp30, 0,
                            Dimens.gap_dp30, Dimens.gap_dp100),
                        child: Column(
                            children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: KitBanner(
                                        index: bloc.getKitIndex(kitName),
                                        onIndexChanged: (index) {
                                            bloc.onIndexChanged(index);
                                        },
                                    ),
                                ),
                                Expanded(
                                    flex: 0,
                                    child: MButton(
                                        text: S.of(context).connect,
                                        color: MColor.button_normal,
                                        onPressed: () {
                                            MonstorNavigator.gotoKitConnect(
                                                context, kitName, state: Constants.CONNECT_STATE_DISCONNECT)
                                                .then((exit) {
                                                if (exit) {
                                                    MonstorNavigator.popPage(context);
                                                }
                                            });
                                        }),
                                ),
                            ],
                        ),));
            });
    }

}
