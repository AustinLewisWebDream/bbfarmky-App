import 'package:bbfarmky/my_widgets/list_style.dart';
import 'package:flutter/material.dart';

class AboutRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(10.0),
                child: Image.asset('assets/images/logo.png',
                    height: 100.0, width: 100.0)),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                  "Bluegrass Blessings Farms & Apiary as a veteran-owned and naturally grown farm located in Lebanon, KY. We are a small family owned and operated farm working hard to produce the healthiest, tastiest, most environmentally sustainable products possible, while bolstering the local community and local business. Our passion is our honeybees and their well-being however weoffer many other farm products for your enjoyment and your family's nutrition. Our main categories of products are: ", style: TextStyle(color: Color.fromRGBO(252, 172, 25, 1))),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              child: ListStyle(
                text: '  * Apiary (Honeybees)',
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              child: ListStyle(
                text: '  * Aviary (Chickens)',
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              child: ListStyle(
                text: '  * Garden (Vegetables)',
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              child: ListStyle(
                text: '  * Orchard (Fruit)', 
                
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                  "We are proud supporters and members of the KY Proud program and the Homegrown By Heroes program.", style: TextStyle(color: Color.fromRGBO(252, 172, 25, 1)),),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                  "Browse our full product availability under the Products tab of this app. The list is updated regularly with products that are currently available as well as products coming soon. An order can easily be placed using the Products tab and we will be notified of your request and contact you for details.", style: TextStyle(color: Color.fromRGBO(252, 172, 25, 1))),
                  
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                  "Please feel free to contact us with any comments, suggestions, or even just to say 'hello'.", style: TextStyle(color: Color.fromRGBO(252, 172, 25, 1))),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                  "Thank you for your interest and support of Bluegrass Blessings Farms & Apiary!", style: TextStyle(color: Color.fromRGBO(252, 172, 25, 1))),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(252, 172, 25, 1), width: 5)),
              margin: EdgeInsets.only(top: 10),
                          child: Container(
                color: Colors.white,
                
                
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Image.asset('assets/images/kyproud.png'),
                        )),
                    Expanded(
                        flex: 5,
                        child: Center(
                            child: Container(
                                
                          child: Column(
                            children: <Widget>[
                              Text('Bluegrass Blessings Farms & Apiary',
                                  style: TextStyle(
                                      color: Color.fromRGBO(4, 116, 188, 1),
                                      fontSize: 12)),
                              Text('680 Tucker Road',
                                  style: TextStyle(
                                      color: Color.fromRGBO(4, 116, 188, 1),
                                      fontSize: 12)),
                              Text('Lebanon, KY 40033',
                                  style: TextStyle(
                                      color: Color.fromRGBO(4, 116, 188, 1),
                                      fontSize: 12)),
                              Text('(502) 600-1004',
                                  style: TextStyle(
                                      color: Color.fromRGBO(4, 116, 188, 1),
                                      fontSize: 12)),
                              Text('www.bbfarmky.com',
                                  style: TextStyle(
                                      color: Color.fromRGBO(4, 116, 188, 1),
                                      fontSize: 12)),
                            ],
                          ),
                        ))),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Image.asset('assets/images/homegrown.png'),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
