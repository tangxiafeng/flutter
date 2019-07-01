import 'package:flutter/material.dart';
import 'package:flutter_monster/blocs/application_bloc.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/models/language.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/widgets/back_button.dart';
import 'package:flutter_monster/widgets/border_button.dart';
import 'package:flutter_monster/widgets/monster_scaffold.dart';

import 'settings_bloc.dart';

class SettingsPage extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        final SettingsBloc bloc = BlocProvider.of<SettingsBloc>(context);

        Locale locale = Localizations.localeOf(context);
        Language current = Language(locale.languageCode, locale.countryCode);
        bool isZh = locale.languageCode == 'zh';

        return MonsterScaffold(
            leftButton: MBackButton(),
            title: S.of(context).settings,
            child: Container(
                padding: EdgeInsets.only(left: Dimens.gap_dp50, top: Dimens.gap_dp30),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Text(
                        S.of(context).language,
                        style: TextStyles.titleContent),
                    Gaps.vGap30,
                    StreamBuilder<Language>(
                        stream: bloc.outLanguage,
                        initialData: current,
                        builder:(BuildContext context, AsyncSnapshot<Language> snapshot) {
                            return Row(
                                children: <Widget>[
                                    MBorderButton(
                                        isSelected: isZh,
                                        text: S.of(context).zh,
                                        onPressed: () {
                                            bloc.onLanguageChanged(Language('zh', 'CN'));
                                        }
                                    ),
                                    Gaps.hGap30,
                                    MBorderButton(
                                        isSelected: !isZh,
                                        text: S.of(context).en,
                                        onPressed: () {
                                            bloc.onLanguageChanged(Language('en', 'US'));
                                        }
                                    ),
                                ],
                            );
                        }),
                ])),
        );
    }
}