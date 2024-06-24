import 'dart:convert';

import 'package:http/http.dart' as http;

Stream<double> getGoldPriceStream() async* {
  final response = await http.get(
    Uri.parse('https://www.goldapi.io/api/XAU/EUR'),
    headers: {
      'x-access-token': 'goldapi-lhp8tslxt32l5k-io',
    },
  );

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonData = jsonDecode(data);
    double goldPrice = double.parse(jsonData['price'].toStringAsFixed(2));
    yield goldPrice;
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}
