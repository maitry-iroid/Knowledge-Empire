import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'constant.dart';


class WebApi {
  static const baseUrl = "http://13.127.186.25/gorham/api/v1/";

  static var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

  var Data;

  Future<dynamic> login(Map<String, String> jsonMap) async {
//    try {
//      final response = await http.post(
//          baseUrl + "slider/images/" + Const.organizationId,
//          headers: headers,body: json.encode(jsonMap));
//
//      if (response.statusCode == 200) {
//        SliderImagesResponse eventResponse =
//            SliderImagesResponse.fromJson(json.decode(response.body));
//
//        return eventResponse;
//      }
//
//      print(response.body);
//      return null;
//    } catch (e) {
//      print(e);
//      return null;
//    }
  }

  /*Future<EventResponse> getPosts(Map jsonMap, int page) async {
    try {
      final response = await http.post(
          baseUrl + "posts?page=" + page.toString(),
          headers: headers,
          body: json.encode(jsonMap));

      print(baseUrl + "posts?page" + page.toString());

      print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        EventResponse eventResponse =
            EventResponse.fromJson(json.decode(response.body));

        return eventResponse;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<EventResponse> redeemRequest(Map jsonMap) async {
    try {
      final response = await http.post(baseUrl + "redeem/offer",
          headers: headers, body: json.encode(jsonMap));

      print(response.body);

      if (response.statusCode == 200) {
        EventResponse eventResponse =
            EventResponse.fromJson(json.decode(response.body));

        print(json.decode(response.body));

        return eventResponse;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<SpecialResponse> getSpecials(
      int currentPage, Map<String, String> jsonMap) async {
    try {
      final response = await http.post(
          baseUrl +
              "specials/" +
              Const.organizationId ,
          headers: headers,
          body: json.encode(jsonMap));

//      final response = await http.post(
//          baseUrl + "posts?page=" + page.toString(),
//          headers: headers,
//          body: json.encode(jsonMap));

      print(response.body);

      if (response.statusCode == 200) {
        SpecialResponse specialResponse =
            SpecialResponse.fromJson(json.decode(response.body));

        print(json.decode(response.body));

        return specialResponse;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<SubScribeResponse> subScribeRequest(Map jsonMap) async {
    try {
      final response = await http.post(baseUrl + "subscribe/to/newsletter",
          headers: headers, body: json.encode(jsonMap));

      print(response.body);

      if (response.statusCode == 200) {
        SubScribeResponse subScribeResponse =
            SubScribeResponse.fromJson(json.decode(response.body));

        print(json.decode(response.body));

        return subScribeResponse;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LocationResponse> getLocations(int page) async {
    try {
      var queryParameters = {'page': page.toString()};

      var uri = Uri.http(
          '13.127.186.25',
          "/gorham/api/v1/list/locations/" + Const.organizationId,
          queryParameters);

      print(uri.path);

      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        LocationResponse locationResponse =
            LocationResponse.fromJson(json.decode(response.body));

        print(json.decode(response.body));
        return locationResponse;
      }

      print(response.body);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LocationResponse> searchLocations(int page, String searchText) async {
    try {
      var queryParameters = {'page': page.toString()};

      var uri = Uri.http(
          '13.127.186.25',
          "/gorham/api/v1/search/locations/" +
              Const.organizationId +
              "/" +
              searchText,
          queryParameters);

      print(uri.path);

      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        LocationResponse locationResponse =
            LocationResponse.fromJson(json.decode(response.body));

        print(json.decode(response.body));
        return locationResponse;
      }

      print(response.body);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }*/
}
