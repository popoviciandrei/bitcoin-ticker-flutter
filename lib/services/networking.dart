import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({@required this.url, this.headers});

  final String url;
  final dynamic headers;

  Future getData() async {
    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print({"Response code: ", response.statusCode, "using mock response"});
//      /*
//      * @TODO remove mock response once app is fully implemented and working
//       */
//      var mockResponse = {
//        "time": "2020-02-05T17:24:48.2127658Z",
//        "asset_id_base": "BTC",
//        "asset_id_quote": "USD",
//        "rate": Random().nextDouble() * 1000 // 9535.409065346604727349343796
//      };
//
//      return mockResponse;
    }
  }
}
