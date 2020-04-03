
import 'dart:convert';

import 'package:bbfarmky/products/product.dart';

class Order {
  final String customerName;
  final String contactInfo;
  var products;
  var data;
  
  Order({this.customerName, this.products, this.contactInfo}){
    var productList = [];

    products.forEach((k, v) => {productList.add({"_id": k, "quantity": v})});
    print(productList.toString());
    data = {
      "name": customerName,
      "contact": contactInfo,
      "products": productList,  
    };
    data = jsonEncode(data);
  }

  List<Product> toList(products, {bool growable = true}) {
      return List<Product>.from(products, growable: growable);
    }

  getJson() {
    return data;
  }
}