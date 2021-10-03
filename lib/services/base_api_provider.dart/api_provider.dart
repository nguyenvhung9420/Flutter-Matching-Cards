import 'package:flutter_matching_cards/services/base_api_provider.dart/api_exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class APIProvider {
  final String _baseUrl = "https://dummyapi.io/data/v1";
  final String _apiKey = "6159d97cb4c477b0a8614dc8";

  Future<dynamic> get({String url = ""}) async {
    var responseJson;
    Map<String, String> headers = {"app-id": _apiKey};
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + url), headers: headers);
      responseJson = decode(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic decode(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
