import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mawqifi/common/globs.dart';

typedef ResSuccess = Future<void> Function(http.Response);
typedef ResFailure = Future<void> Function(dynamic);

class ServiceCall {
  static Map userObj = {};
  static int userType = 1;

  static void post(
    Map<String, dynamic> parameter,
    String path, {
    bool isTokenApi = false,
    ResSuccess? withSuccess,
    ResFailure? withFailure,
  }) {
    Future(() {
      try {
        var headers = {"Content-Type": "application/json"};
        if (isTokenApi) {
          var token = Globs.udValueString(PreferenceKey.token);
          headers["Authorization"] = 'Bearer $token';
        }
        print(path.toString());
        print(parameter);
        print(headers);
        http
            .post(Uri.parse(path),
                body: jsonEncode(parameter), headers: headers)
            .timeout(
          const Duration(seconds: 30),
          onTimeout: () {
            throw Exception("Request Time out");
          },
        ).then(
          (value) {
            try {
              if (withSuccess != null) withSuccess(value);
            } catch (e) {
              if (withFailure != null) withFailure(e.toString());
            }
          },
        ).catchError((e) {
          if (withFailure != null) withFailure(e.toString());
        });
      } catch (e) {
        if (withFailure != null) withFailure(e.toString());
      }
    });
  }

  static void get(
    Map<String, dynamic> parameter,
    String path, {
    bool isTokenApi = false,
    ResSuccess? withSuccess,
    ResFailure? withFailure,
  }) {
    Future(() {
      if (kDebugMode) {
        print(parameter);
      }
      try {
        var headers = {"Content-Type": "application/json"};
        if (isTokenApi) {
          var token = Globs.udValueString(PreferenceKey.token);
          headers["Authorization"] = 'Bearer $token';
        }
        if (kDebugMode) {
          print(Uri.parse(path).replace(queryParameters: parameter));
          print(headers);
        }
        http.get(Uri.parse(path).replace(queryParameters: parameter),headers: headers).timeout(
          const Duration(seconds: 30),
          onTimeout: () {
            throw Exception("Request Time out");
          },
        ).then(
          (value) {
            try {
              if (withSuccess != null) withSuccess(value);
            } catch (e) {
              if (withFailure != null) withFailure(e.toString());
            }
          },
        ).catchError((e) {
          if (withFailure != null) withFailure(e.toString());
        });
      } catch (e) {
        if (withFailure != null) withFailure(e.toString());
      }
    });
  }
}
