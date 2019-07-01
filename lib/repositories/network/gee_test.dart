import 'dart:async';

import 'package:flutter_monster/utils/constants.dart';
import 'package:gt3/gt3.dart';

class GeeTest {

	Future<String> show() async {
		return Gt3.showGeeTest('${Constants.USER_CENTER_LOCAL}${Constants.URL_PATH_GT3}');
	}



}