// To parse this JSON data, do
//
//     final allCurrency = allCurrencyFromJson(jsonString);

import 'dart:convert';

Map<String, String> allCurrencyFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) => MapEntry<String, String>(k, v));

String allCurrencyToJson(Map<String, String> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));
