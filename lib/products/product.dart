import 'package:flutter/material.dart';
import '../cart.dart';

class Product {
  String id;
  String name;
  var price; // Double or Int
  String priceString;
  String availability;
  String variety;
  String category;
  List measurement;

  Product(
      {this.id,
      this.name,
      this.price,
      this.availability,
      this.variety,
      this.category,
      this.measurement
     });



  Product.fromJson(Map<String, dynamic> jsonMap) {
    this.id = jsonMap['id'];
    final _fields = jsonMap['fields'];
    this.name = _fields['Name'];
    this.price = _fields['Price'];
    this.availability = _fields['Availability'];
    this.variety = _fields['Variety'];
    this.category = _fields['Category'];
    this.measurement = _fields['Sold By'];

    if (this.measurement == null) this.measurement = [''];
    if (this.name == null) this.name = '';
    
    if (this.availability == null) this.availability = '';
    if (this.variety == null) this.variety = '';
    if (this.category == null) this.category = '';
    if (this.price == null) this.price = 0;
    if (this.price != 0) this.formatPrice();
  }

  void formatPrice() {
    // Possible inputs 5, 5.5, 0.5, 5.55
    // Convert price to a string
    this.priceString = price.toString();

    // Check if length is equal to correct length (4 characters)
    if(this.priceString.length == 4) 
      this.priceString = '\$' + this.priceString.toString();
    else if(this.priceString.length == 3) 
      this.priceString = '\$' + this.priceString.toString() + '0';
    else
      this.priceString = '\$' + this.priceString.toString() + '.00';

    this.priceString += '/' + this.measurement[0];
  }

  printDebug() {
    print('Name: ' + this.name);
    print('Price: ' + this.price.toString());
    print('Availability: ' + this.availability);
    print('Sold By: ' + this.measurement[0]);
  }
}

class ProductWidget extends StatefulWidget {
  final Product product;
  final Function notifyParent;
  ProductWidget(this.product, this.notifyParent);
  
  @override
  State<StatefulWidget> createState() {
    
    return _ProductWidget(product, notifyParent);
  }
}

class _ProductWidget extends State<ProductWidget> {
  final Function notifyParent;
  Product product;
  Cart cart = new Cart();
  Color backgroundColor = Colors.red;
  
  _ProductWidget(this.product, this.notifyParent);

  Color _selectedColor() {
    if(cart.containsProduct(product)) 
      return Color.fromRGBO(252, 172, 25, 1);
    else
      return Colors.white;
  }

  @override
  void initState() {
    backgroundColor = _selectedColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
     backgroundColor = _selectedColor(); 
    });
    return GestureDetector(
          onTap: () {
            cart.toggleItem(product);
            this.notifyParent();
            setState(() {
             backgroundColor = _selectedColor(); 
            });
          },
          child: Card(
        color: backgroundColor,
        margin: EdgeInsets.all(5.0),
        child: Container(
          margin: EdgeInsets.all(10.0),

          child: Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(5.0),
                        child: Text(
                          product.name,
                          style: TextStyle(fontSize: 15.0),
                        )),
                    Container(
                        margin: EdgeInsets.all(5.0),
                        child: Text(product.priceString,
                            style: TextStyle(fontSize: 11.0))),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(5.0),
                        child: Text(product.variety,
                            style: TextStyle(fontSize: 12.0))),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(5.0),
                        child: Text(product.availability,
                            style: TextStyle(fontSize: 12.0))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
