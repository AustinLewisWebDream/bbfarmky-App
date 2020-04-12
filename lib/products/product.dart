import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../cart.dart';

class Product {
  String id; 
  String name; 
  var price; /// Double or Int
  String availability; 
  String measurement;
  String variety;

  String priceString; 
  String category;

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
    this.id = jsonMap['_id'];
    this.name = jsonMap['name'];
    this.price = jsonMap['price'];
    this.availability = jsonMap['available'];
    this.variety = jsonMap['variety'];
    this.category = '';
    this.measurement = jsonMap['measurement'];

    if (this.measurement == null) this.measurement = '';
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

    this.priceString += '/' + this.measurement;
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
                        child: AutoSizeText(
                          product.name,
                          style: TextStyle(fontSize: 15.0),
                          maxLines: 1
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
