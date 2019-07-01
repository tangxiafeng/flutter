import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/log.dart';

class BaseResponse<T> {
    int code;
    T data;

    BaseResponse(this.code, this.data);
}

class HttpUtil {
    static final HttpUtil _singleton = HttpUtil._init();
    static Dio _dio;

    String _codeKey = 'errorCode';
    String _dataKey = 'data';

    static bool _isDebug = true;

    static HttpUtil getInstance() {
        return _singleton;
    }

    factory HttpUtil() {
        return _singleton;
    }

    HttpUtil._init() {
        _dio = new Dio();
        _dio.options.connectTimeout = Constants.CONNECT_TIMEOUT; //5s
        _dio.options.receiveTimeout = Constants.RECEIVE_TIMEOUT;
        _dio.options.headers = {
            'Content-Type': 'application/json',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'Accept': 'application/json',
        };
    }

    static void openDebug() {
        _isDebug = true;
    }

    Future<BaseResponse<T>> request<T>(String method, String path,
        {data, Options options, CancelToken cancelToken}) async {
        Log.e('base url ==== ' + _dio.options.baseUrl);
        Log.e('path ==== ' + path);
        Log.e('headers ==== ' + _dio.options.headers.toString());

        Response response = await _dio.request(
            path,
            data: data,
            options: _checkOptions(method, options),
            cancelToken: cancelToken);

        int _code;
        T _data;

        if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
            try {
                if (response.data is Map) {
                    _code = (response.data[_codeKey] is String)
                        ? int.tryParse(response.data[_codeKey])
                        : response.data[_codeKey];
                    _data = response.data[_dataKey];
                } else {
                    Map<String, dynamic> _dataMap = _decodeData(response);
                    _code = (_dataMap[_codeKey] is String)
                        ? int.tryParse(_dataMap[_codeKey])
                        : _dataMap[_codeKey];
                    _data = _dataMap[_dataKey];
                }
                return BaseResponse(_code, _data);
            } catch (e) {
                return new Future.error(new DioError(
                    response: response,
                    message: "data parsing exception...",
                    type: DioErrorType.RESPONSE,
                ));
            }
        }
        return Future.error(DioError(
                response: response,
                message: 'statusCode: $response.statusCode, service error',
                type: DioErrorType.RESPONSE));
    }

    Map<String, dynamic> _decodeData(Response response) {
        if (response == null || response.data == null || response.data.toString().isEmpty) {
            return new Map();
        }
        return json.decode(response.data.toString());
    }

    Options _checkOptions(method, options) {
        if (options == null) {
            options = new Options();
        }
        options.method = method;
        return options;
    }

    Dio getDio() {
        return _dio;
    }

}
