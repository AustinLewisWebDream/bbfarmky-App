import 'package:bbfarmky/orders/order_form.dart';
import 'package:bbfarmky/orders/order_product.dart';
import '../cart.dart';
import 'package:flutter/material.dart';

class OrdersRoute extends StatelessWidget {
  final Cart cart = new Cart();
  bool get cartEmpty => cart.isEmpty();

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(children: <Widget>[
          Column(
            children: cart.getProducts().map((element) => OrderProduct(product: element,)).toList(),
          ),
          OrderForm()
        ],)
      ),
    );
  }
}