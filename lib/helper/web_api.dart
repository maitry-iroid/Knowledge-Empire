import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/login_response.dart';

class WebApi {
  static const baseUrl = "http://13.127.186.25:7000/api";

  static var headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader:
        Injector.userData == null ? "" : "pig " + Injector.userData.accessToken,
    'devicetype': 'android',
    'deviceid': Injector.deviceId
  };

  static getRequest(String req, String data) {
    return {
      'api_id': 'e1530f4d52b7a5b806e2b051e72c80ef',
      'api_secret': '1a42cc080ef2464a60134473276fe42e',
      'api_request': req,
      'data': data
    };
  }

  static BaseOptions options = new BaseOptions(
      baseUrl: "http://13.127.186.25:7000/api",
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers);

  Dio dio = Dio(options);

  Future<LoginResponse> login(Map<String, dynamic> jsonMap) async {
    try {
      final response = await dio.post("",
          data: json.encode(getRequest('login', json.encode(jsonMap))));

      if (response.statusCode == 200) {
        print(response.data);
        LoginResponse loginRequest =
            LoginResponse.fromJson(jsonDecode(response.data));
        return loginRequest;
      }

      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LoginResponse> forgotPassword(Map<String, dynamic> jsonMap) async {
    try {
      final response = await dio.post("",
          data:
              json.encode(getRequest('forgot_password', json.encode(jsonMap))));

      if (response.statusCode == 200) {
        print(response.data);
        LoginResponse loginRequest =
            LoginResponse.fromJson(jsonDecode(response.data));
        return loginRequest;
      }
      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LoginResponse> changePassword(Map<String, dynamic> jsonMap) async {


    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:
      Injector.userData == null ? "" : "pig " + Injector.userData.accessToken,
      'devicetype': 'android',
      'deviceid': Injector.deviceId
    };

    print("change_password_request__"+json.encode(jsonMap));
    print("headers"+headers.toString());

    try {
      final response = await dio.post("",
          data:
              json.encode(getRequest('change_password', json.encode(jsonMap))));

      if (response.statusCode == 200) {
        print(response.data);
        LoginResponse loginRequest =
            LoginResponse.fromJson(jsonDecode(response.data));
        return loginRequest;
      }

      print(response.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

}
