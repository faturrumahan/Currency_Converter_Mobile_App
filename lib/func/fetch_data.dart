import 'package:convert_app/model/currency_model.dart';
import 'package:convert_app/model/rates_model.dart';
import 'package:convert_app/key.dart';
import 'package:http/http.dart' as http;

Future<Rates> fetchrates() async {
  var response = await http.get(Uri.parse('https://openexchangerates.org/api/latest.json?base=USD&app_id=' + key));
  final rates = ratesFromJson(response.body);
  return rates;
}

Future<Map> fetchcurrencies() async {
  var response = await http.get(Uri.parse('https://openexchangerates.org/api/currencies.json?app_id=' + key));
  final currencies = allCurrencyFromJson(response.body);
  return currencies;
}
