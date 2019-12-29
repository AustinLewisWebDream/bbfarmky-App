import 'package:bbfarmky/orders/order_form.dart';
import 'package:bbfarmky/orders/order_product.dart';
import 'package:bbfarmky/products/product_route.dart';
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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(child: Text("Swipe to remove item", style: TextStyle(color: Color.fromRGBO(255, 255, 255, .5)),)),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: showCartDisplay()
      )
    );
  }
  Widget showCartDisplay() {
    if(cart.isEmpty()) return NoItemsWidget();
    else return ShowCartWidget();
  }
}

class NoItemsWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Color.fromRGBO(4, 116, 188, 1),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Container(margin: EdgeInsets.all(10.0) ,child: Text('No Products Yet!', style: Theme.of(context).textTheme.title,),),
          RaisedButton(child: Text('View Products'), onPressed: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProductsRoute()));
          },)
        ],),);
  }
}

class ShowCartWidget extends StatelessWidget {
  final Cart cart = new Cart();
  Widget build(BuildContext context) {
    return 
        ListView(children: <Widget>[
          Column(
            children: cart.getProducts().map((element) => OrderProduct(product: element,)).toList(),
          ),
          OrderForm()
        ]);
  }
}

