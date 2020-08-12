import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<String> _loadProducts() async {
  return await rootBundle.loadString('lib/data/products.json');
}

Future loadDummyProducts() async {
  String jsonProdcuts = await _loadProducts();
  return json.decode(jsonProdcuts);
  print("JSON" + json.decode(jsonProdcuts)["products"].length.toString());
}
