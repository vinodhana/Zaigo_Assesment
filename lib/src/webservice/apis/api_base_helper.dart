import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:zaigo_assesment/src/utils/app_preferences.dart';
import 'package:zaigo_assesment/src/webservice/webservice_constants.dart';
import 'package:flutter/cupertino.dart';
import 'AppException.dart';
import 'api_config.dart';
import 'simplified_uri.dart';

import 'package:http/http.dart' as http;

class ApiBaseHelper {
  static String apiBaseUrl = baseUrl;

  static final ApiBaseHelper _singleton = ApiBaseHelper._internal();

  factory ApiBaseHelper() {
    return _singleton;
  }

  static const int successCode = 200;
  static const int badRequest = 400;

  ApiBaseHelper._internal();

  Future<dynamic> getApiCall({
    BuildContext? context,
    required String url,
    String? currentPageNo,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    headers ??= {};
    headers.addAll({
      WebserviceConstants.authorization:
          'Bearer ' + await AppPreferences.getAuthenticationToken(),
    });

    headers.addAll({
      WebserviceConstants.contentType: WebserviceConstants.applicationJson,
      WebserviceConstants.deviceType: WebserviceConstants.mobile,
    });

    dynamic apiResponse;

    final Uri uri;
    if (currentPageNo != null && currentPageNo != '') {
      uri = Uri.parse(apiBaseUrl + url + currentPageNo);
    } else {
      uri = SimplifiedUri.uri(apiBaseUrl + url, queryParameters);
    }
    debugPrint("ApiBaseUrl " + uri.path);
    try {
      final http.Response response = await http.get(
        uri,
        headers: headers,
      );

      try {
        apiResponse = _returnResponse(response: response);
        return apiResponse;
      } on UnauthorisedException {
        _redirectToLogin(context!);
      } catch (e) {
        apiResponse = json.decode(response.body.toString());
        return apiResponse;
      } finally {}
    } on SocketException {
      Map<String, String> jsonData = {'message': 'No Internet connection'};
      await Future.delayed(const Duration(seconds: 2));
      return jsonData;
    }
  }

  _redirectToLogin(BuildContext context) async {
    bool isLogin = await AppPreferences.getLoginStatus();
    if (isLogin) {
      // pushNamedAndRemoveAll(context, Routes.homeScreen);
    }
  }

  Future<dynamic> postApiCall(
      {required String url,
      Map<String, String>? headers,
      required Map<String, dynamic> jsonData}) async {
    headers ??= {};

    headers.addAll({
      WebserviceConstants.contentType: WebserviceConstants.applicationJson,
      WebserviceConstants.deviceType: WebserviceConstants.mobile,
    });

    dynamic apiResponse;

    try {
      final http.Response response = await http.post(
        Uri.parse(apiBaseUrl + url),
        headers: headers,
        body: jsonEncode(jsonData),
      );

      try {
        apiResponse = _returnResponse(response: response);
        return apiResponse;
      } catch (e) {
        apiResponse = json.decode(response.body.toString());
        return apiResponse;
      } finally {}
    } on SocketException {
      Map<String, String> jsonData = {'message': 'No Internet connection'};
      await Future.delayed(const Duration(seconds: 2));
      return jsonData;
    }
  }

  Map<String, dynamic> _returnResponse({required http.Response response}) {
    Map<String, dynamic> responseJson;
    switch (response.statusCode) {
      case 200:
        responseJson = jsonDecode(response.body);
        responseJson
            .addAll({WebserviceConstants.statusCode: response.statusCode});
        debugPrint('responseJson  ' + responseJson.toString());
        debugPrint('responseJson  ' + response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());

      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw ForbiddenException(response.body.toString());

      case 404:
        throw NotFoundException(response.body.toString());
      case 500:
        throw InternalServerErrorException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<Map<String, String>> addAuthenticationHeader() async {
    return {
      WebserviceConstants.authorization:
          'Bearer ' + await AppPreferences.getAuthenticationToken(),
      //WebserviceConstants.firebaseToken: await AppPreferences.getFCMToken(),
      WebserviceConstants.contentType: WebserviceConstants.applicationJson
    };
  }
}
