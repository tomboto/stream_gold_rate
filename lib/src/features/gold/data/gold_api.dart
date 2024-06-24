import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Stream<double> getGoldPriceStream() async* {
  final Uri url = Uri.parse('https://www.goldapi.io/api/XAU/EUR');
  final headers = {'x-access-token': 'goldapi-lhp8tslxt32l5k-io'};

  while (true) {
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        double goldPrice = jsonData['price'];
        yield goldPrice;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
    // Warte eine vorgegebenen Zeit lang bis zur nächsten Anfrage
    // (Zeitspanne erhöhen, um die Anzahl der Abfragen zu reduzieren!!!)
    await Future.delayed(const Duration(seconds: 1));
  }
}
