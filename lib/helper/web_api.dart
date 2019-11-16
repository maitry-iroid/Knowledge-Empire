import 'dart:convert';
import 'dart:io';

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

  Future<LoginResponse> login(Map<String, dynamic> jsonMap) async {
    try {
      final response = await http.post(baseUrl,
          headers: headers,
          body: json.encode(getRequest('login', json.encode(jsonMap))));

      if (response.statusCode == 200) {
        print(response.body);
        LoginResponse loginRequest =
            LoginResponse.fromJson(jsonDecode(response.body));
        return loginRequest;
      }

      print(response.body);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LoginResponse> forgotPassword(Map<String, dynamic> jsonMap) async {
    try {
      final response = await http.post(baseUrl,
          headers: headers,
          body:
              json.encode(getRequest('forgot_password', json.encode(jsonMap))));

      if (response.statusCode == 200) {
        print(response.body);
        LoginResponse loginRequest =
            LoginResponse.fromJson(jsonDecode(response.body));
        return loginRequest;
      }
      print(response.body);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LoginResponse> changePassword(Map<String, dynamic> jsonMap) async {
    try {
      final response = await http.post(baseUrl,
          headers: headers,
          body:
              json.encode(getRequest('change_password', json.encode(jsonMap))));

      if (response.statusCode == 200) {
        print(response.body);
        LoginResponse loginRequest =
            LoginResponse.fromJson(jsonDecode(response.body));
        return loginRequest;
      }

      print(response.body);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
