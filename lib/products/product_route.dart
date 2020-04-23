import 'package:bbfarmky/my_widgets/loading_indicator.dart';
import 'package:bbfarmky/orders/orders_route.dart';
import '../post.dart';
import 'package:bbfarmky/products/product.dart';
import 'package:flutter/material.dart';
import '../cart.dart';

class ProductsRoute extends StatefulWidget {
  final Sort sortBy;
  ProductsRoute({this.sortBy});
  @override
  State<StatefulWidget> createState() {
    return _ProductsRoute(sortBy);
  }
}

class _ProductsRoute extends State<ProductsRoute> {
  Cart cart = new Cart();
  bool showOrderButton = false;
  int numItems;
  List<Product> products;
  bool loading = true;
  Sort sortBy;
 _ProductsRoute(this.sortBy);
  

  @override
  void initState() {
    super.initState();
    notifyCartChange();
    loadProducts(sortBy);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: buildChildren(context),
        appBar: AppBar(
          title: Text('Products'),
          actions: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(right: 15),
                child: Row(
                  children: <Widget>[
                    DropdownButton(
                      value: sortBy,
                      hint: Text('Sort'),
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(value: Sort.name, child: Text('Name', style: TextStyle(color: Color.fromRGBO(252, 172, 25, 1)))),
                        DropdownMenuItem(
                          value: Sort.availability,
                          child: Text('Availability', style: TextStyle(color: Color.fromRGBO(252, 172, 25, 1)),),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          sortBy = value;
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProductsRoute(sortBy: sortBy,)));
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        body: Container(
            child: buildProducts(context)
        )
    );
  }

  Widget buildProducts(BuildContext context) {
    if(loading) return LoadingIndicator();
    else {
      print(products.toString());
      return ListView(
                children: products
                    .map((element) => ProductWidget(element, notifyCartChange))
                    .toList());
    }

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

  void loadProducts(Sort sortBy) {
    Products.fetchProducts(sortBy).then((products) {setState(() {
     loading = false;
     this.products = products.sortedProducts; 
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
