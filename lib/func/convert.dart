String convert(Map rates, String amount, String from, String to) {
  String output = (double.parse(amount) / rates[from] * rates[to])
      .toStringAsFixed(2)
      .toString();
  return output;
}