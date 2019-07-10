import 'dart:io';
import 'package:bbfarmky/airtable_api/new_order.dart';
import 'package:bbfarmky/cart.dart';
import 'package:bbfarmky/orders/complete_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class OrderForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderForm();
  }
}

final nameController = TextEditingController();
final contactController = TextEditingController();

@override
void dispose() {
  // Clean up the controller when the widget is disposed.
  nameController.dispose();
  contactController.dispose();
}

class _OrderForm extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  final Cart cart = new Cart();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 18.0),
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Name';
                    }
                  },
                  decoration: InputDecoration(labelText: 'Name')),
              TextFormField(
                  controller: contactController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Email or Phone Number';
                    }
                  },
                  decoration:
                      InputDecoration(labelText: 'Email or Phone Number')),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate()) {
                        createOrder();

                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Return status code of order request
  createOrder() async {
    var json = Order(
            customerName: nameController.text, products: cart.getProductQuantityMap(), contactInfo: contactController.text)
        .getJson();

    print(json.toString());


    Response response =
        await post('https://www.bbfarmky.com/app/order',
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer vE9LqElUzA',
              'Content-Type': 'application/json'
            },
            body: json);

    if (response.statusCode == 200) {
      cart.empty();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CompleteRoute()));
    } else {
      // TODO: Better error handling
      print('Error submitting order');
    }
  }
}
