import 'package:bbfarmky/products/product.dart';
import 'package:flutter/material.dart';

import '../cart.dart';

class OrderProduct extends StatefulWidget {
  final Product product;
  OrderProduct({this.product});
  @override
  State<StatefulWidget> createState() {
    return _OrderProduct(product);
  }
}

class _OrderProduct extends State<OrderProduct> {
  Cart cart = new Cart();
  Product _product;
  int quantity;
  _OrderProduct(this._product);

  @override
  void initState() {
    super.initState();
    quantity = cart.getQuantity(_product);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: Card(
          child: ListTile(
        title: Text(_product.name),
        subtitle: Text(
          _product.priceString,
        ),
        trailing: Container(
          height: 70,
          width: 100,
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.indeterminate_check_box, size: 30),
                onTap: () {
                  decrementQuantity();
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Text(this.quantity.toString()),
              ),
              GestureDetector(
                child: Icon(
                  Icons.add_box,
                  size: 30,
                ),
                onTap: () {
                  incrementQuantity();
                },
              ),
            ],
          ),
        ),
      )),
      key: ObjectKey(_product.id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        cart.removeProduct(_product);
      },
      background: Container(child: Icon(Icons.remove_shopping_cart, color: Colors.white, ), color: Colors.red, alignment: Alignment.centerRight, padding: EdgeInsets.only(right: 15),),
    );
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
    cart.updateQuantity(_product, quantity);
  }

  void decrementQuantity() {
    if (quantity == 1) return;
    setState(() {
      quantity--;
    });
    cart.updateQuantity(_product, quantity);
  }
}
