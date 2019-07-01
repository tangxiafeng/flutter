/*
 * Created by gloria on 2018/1/9.
 */

class Log {
    static const String _TAG = "Monster";

    static bool debuggable = false;
    static String logTAG = _TAG;

    static void init({bool isDebug: false, String tag: _TAG}) {
        debuggable = isDebug;
        logTAG = tag;
    }

    static void e(Object object, {String tag}) {
        _printLog(tag, ' : e : ----> ', object);
    }

    static void v(Object object, {String tag}) {
        if (debuggable) {
            _printLog(tag, ' : v : ----> ', object);
        }
    }

    static void _printLog(String tag, String stag, Object object) {
        StringBuffer sb = new StringBuffer();
        sb.write((tag == null || tag.isEmpty) ? logTAG : tag);
        sb.write(stag);
        sb.write(object);
        print(sb.toString());
    }
}