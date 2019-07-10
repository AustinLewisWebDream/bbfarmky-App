import 'package:bbfarmky/my_widgets/loading_indicator.dart';
import 'package:bbfarmky/orders/orders_route.dart';
import '../post.dart';
import 'package:bbfarmky/products/product.dart';
import 'package:flutter/material.dart';
import '../cart.dart';

class ProductsRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductsRoute();
  }
}

class _ProductsRoute extends State<ProductsRoute> {
  Cart cart = new Cart();
  bool showOrderButton = false;
  int numItems;
  List<Product> products;
  dynamic _value = Sort.name;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    notifyCartChange();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      products = Products.sortedProducts;
    });
    return Scaffold(
        floatingActionButton: buildChildren(context),
        appBar: AppBar(
          title: Text('Products'),
          actions: <Widget>[
            // Center(
            //   child: Container(
            //     margin: EdgeInsets.only(right: 15),
            //     child: Row(
            //       children: <Widget>[
            //         Container(
            //             margin: EdgeInsets.only(right: 10),
            //             child: Text('Sort By: ')),
            //         DropdownButton(
            //           value: _value,
            //           hint: Text('Sort'),
            //           items: <DropdownMenuItem>[
            //             DropdownMenuItem(value: Sort.name, child: Text('Name')),
            //             DropdownMenuItem(
            //               value: Sort.availability,
            //               child: Text('Availability'),
            //             ),
            //           ],
            //           onChanged: (value) {
            //             setState(() {
            //               _value = value;
            //               products = Products.sortBy(value);
            //               products.forEach((product) => print(product.name));
            //             });
            //           },
            //         )
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
        body: Container(
            child: buildProducts(context)
        )
    );
  }

  Widget buildProducts(BuildContext context) {
    if(loading) return LoadingIndicator();
    else
      return ListView(
                children: products
                    .map((element) => ProductWidget(element, notifyCartChange))
                    .toList());
  }

  Widget buildChildren(BuildContext context) {
    if (showOrderButton)
      return FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OrdersRoute()));
        },
        icon: Icon(
          Icons.shopping_basket,
          color: Color.fromRGBO(252, 172, 25, 1),
        ),
        backgroundColor: Color.fromRGBO(4, 116, 188, 1),
        label: Text(
          'Order Now',
          style: TextStyle(color: Color.fromRGBO(252, 172, 25, 1)),
        ),
      );
    else
      return null;
  }

  void loadProducts() {
    Products.fetchProducts().then((products) {setState(() {
     loading = false;
     this.products = products.products; 
    });});
  }

  void notifyCartChange() {
    if (cart.isEmpty()) {
      setState(() {
        showOrderButton = false;
        numItems = cart.getNumItems();
      });
    } else {
      setState(() {
        showOrderButton = true;
        numItems = cart.getNumItems();
      });
    }
  }
}
