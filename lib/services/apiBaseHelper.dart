import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ApiBaseHelper {
  final String _baseUrl =
      "https://us-central1-techspardha-87928.cloudfunctions.net/api/";
  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw AppException('No Internet connection', 500);
    }
    return responseJson;
  }

  Future<dynamic> put(String url, Object body) async {
    print('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(Uri.parse(_baseUrl + url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw AppException('No Internet connection', 500);
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Object body) async {
    print('Api post, url $url');
    var responseJson;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw AppException('No Internet connection', 500);
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      default:
        throw AppException(response.body.toString(), response.statusCode);
    }
  }
}

class AppException implements Exception {
  final message;
  final int? code;
  AppException([this.message, this.code]);
  String toString() {
    return "$message:$code";
  }
}
