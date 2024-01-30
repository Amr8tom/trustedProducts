import 'dart:convert';

import 'package:get/get_connect.dart';
import 'dart:convert';
import '/utils/base_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BcodesRepo{

  // static final var jsonCode;
  static Future fetchData() async {
    final response = await http.get(Uri.parse(API.Baseurl));
    return jsonDecode(response.body);
  }

  }




