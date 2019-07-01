import 'dart:async';

import 'package:flutter_monster/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class LocalStorage {
    static LocalStorage _singleton;
    static SharedPreferences _prefs;

    static Future<LocalStorage> getInstance() async {
        if (_singleton == null) {
            _singleton = LocalStorage._();
            await _singleton._init();
        }
        return _singleton;
    }

    LocalStorage._();

    Future _init() async {
        _prefs = await SharedPreferences.getInstance();
        // default value
        if (!_prefs.getKeys().contains(Constants.KEY_USER_CENTER_ADDRESS)) {
            setString(
                Constants.KEY_USER_CENTER_ADDRESS, Constants.USER_CENTER_LOCAL);
            setString(Constants.KEY_PROJECTS_ADDRESS, Constants.PROJECTS_LOCAL);
        }
    }

    static String getString(String key) {
        if (_prefs == null) return null;
        return _prefs.getString(key);
    }

    static Future<bool> setString(String key, String value) {
        if (_prefs == null) return null;
        return _prefs.setString(key, value);
    }

    static bool getBool(String key) {
        if (_prefs == null) return null;
        return _prefs.getBool(key);
    }

    static Future<bool> setBool(String key, bool value) {
        if (_prefs == null) return null;
        return _prefs.setBool(key, value);
    }

    static int getInt(String key) {
        if (_prefs == null) return null;
        return _prefs.getInt(key);
    }

    static Future<bool> setInt(String key, int value) {
        if (_prefs == null) return null;
        return _prefs.setInt(key, value);
    }

    static dynamic getDynamic(String key) {
        if (_prefs == null) return null;
        return _prefs.get(key);
    }

    static Set<String> getKeys() {
        if (_prefs == null) return null;
        return _prefs.getKeys();
    }

    static Future<bool> remove(String key) {
        if (_prefs == null) return null;
        return _prefs.remove(key);
    }

    static Future<bool> clear() {
        if (_prefs == null) return null;
        return _prefs.clear();
    }

}
