import 'package:flutter_matching_cards/services/base_api_provider.dart/api_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class PeopleAPIProvider extends APIProvider {
  Future<dynamic> getPeople({int limit = 10}) {
    String url = "/user?limit=" + limit.toString();
    return super.get(url: url);
  }
}
