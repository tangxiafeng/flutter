import 'dart:async';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/utils/event_bus.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/blocs/application_bloc.dart';
import 'package:flutter_monster/pages/splash/splash_bloc.dart';
import 'package:flutter_monster/pages/splash/splash_page.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'models/language.dart';

/*
 * Created by gloria on 2018/1/9.
 */

Future<void> main() async {
    return runApp(
        BlocProvider<ApplicationBloc>(
            bloc: ApplicationBloc(),
            child: BlocProvider<SplashBloc>(
                bloc: SplashBloc(),
                child: MyApp(),
            ),
        )
    );
}

class MyApp extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return MyAppState();
    }
}

class MyAppState extends State<MyApp> {
    Locale _locale;

    @override
    void initState() {
        super.initState();
        _initAsync();
    }

    void _initAsync() async {
        await LocalStorage.getInstance();

        final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
        _loadLocale(bloc.getCurrentLanguage());
        EventBus().register((event) {
            _loadLocale(event.language);
        });

        await PermissionHandler().requestPermissions([PermissionGroup.location]);
        await PermissionHandler().requestPermissions([PermissionGroup.camera]);
        await PermissionHandler().requestPermissions([PermissionGroup.microphone]);
    }

    void _loadLocale(Language model) {
        setState(() {
            if (model != null) {
                _locale = Locale(model.languageCode, model.countryCode);
            } else {
                _locale = null;
            }
        });
    }

    @override
    void dispose() {
        super.dispose();
    }

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return OKToast(
            child: MaterialApp(
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    primaryColor: Colors.blue,
                ),
                home: SplashPage(),
                locale: _locale,
                localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    S.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
            )
        );
    }
}
