import 'dart:convert';
import 'dart:io';
import 'package:bbfarmky/products/product.dart';
import 'package:http/http.dart';

enum Sort { name, availability }

class Products {
  List<Product> products = [];
  List<Product> sortedProducts = [];

  Products.fromJson(String jsonStr, Sort algorithm) {
    products = [];
    sortedProducts = [];
    final _productsList = jsonDecode(jsonStr);
    for (var i = 0; i < (_productsList.length); i++) {
      Product newProduct = Product.fromJson(_productsList[i]);
      if(productIsComplete(newProduct)){
        products.add(newProduct);
        sortedProducts.add(newProduct);
      }
    }
    sortBy(algorithm);
  }
  
  static Future<Products> fetchProducts(sort) async {
    final response = await get(
      //'https://app.bbfarmky.com/api/item'
        'http://10.0.2.2:3001/api/item',
        headers: {HttpHeaders.authorizationHeader: 'Bearer keyeIMUytOcC820fT'});
    if (response.statusCode == 200) {
      print(response.body.toString());
      return Products.fromJson(response.body, sort);
    }
    throw Exception('Failed to load post');
  }

  List<Product> sortBy(Sort algorithm) {
    switch(algorithm) {
      case Sort.name:
        sortedProducts.sort((a, b) => (a.name.compareTo(b.name)));
        break;
      case Sort.availability:
        sortedProducts.sort((a, b) => (a.availability.compareTo(b.availability)));
        break;
    }
    return sortedProducts;
  }

  bool productIsComplete(Product product) {
    return true;
  }

  static void _byName() {
    
  }

  static void _byAvailability() {
    
  }

  printDebug() {
    print(sortedProducts.length.toString());
    sortedProducts.forEach((product) => print(product.printDebug()));
  }
}