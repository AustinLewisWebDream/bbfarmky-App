import 'package:bbfarmky/about/about_route.dart';
import 'package:bbfarmky/coming_soon.dart';
import 'package:bbfarmky/home/footer.dart';
import 'package:bbfarmky/home/menu_item.dart';
import 'package:bbfarmky/orders/orders_route.dart';
import 'package:bbfarmky/products/product_route.dart';
import 'package:bbfarmky/schedule/schedule_route.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeMenu extends StatefulWidget {
  @override
  State<HomeMenu> createState() {
    return _HomeMenu();
  }
}

class _HomeMenu extends State<HomeMenu> {
  bool contactMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
            margin: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset('assets/images/logo.png',
                        height: 150.0, width: 150.0),
                    Container(
                        margin: EdgeInsets.all(18.0),
                        child: Text(
                          'Fresh, Local, and Naturally Grown!',
                          style: TextStyle(
                              color: Color.fromRGBO(252, 172, 25, 1),
                              fontFamily: 'Lato',
                              fontSize: 25.0),
                        )),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: MenuItem(
                                  itemText: 'Products',
                                  imagePath: 'assets/images/products.png',
                                  route: ProductsRoute(),
                                ),
                              ),
                              MenuItem(
                                itemText: 'Orders',
                                imagePath: 'assets/images/orders.png',
                                route: OrdersRoute(),
                              ),
                              MenuItem(
                                itemText: 'Schedule',
                                imagePath: 'assets/images/schedule.png',
                                route: ScheduleRoute(),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              MenuItem(
                                itemText: 'News',
                                imagePath: 'assets/images/news.png',
                                route: ComingSoon(),
                              ),
                              MenuItem(
                                itemText: 'Contact',
                                imagePath: 'assets/images/contact.png',
                                callback: openContactMenu,
                              ),
                              MenuItem(
                                itemText: 'About',
                                imagePath: 'assets/images/about.png',
                                route: AboutRoute(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Footer()
                  ],
                ),
                PopupMenu(
                  open: contactMenuOpen,
                  closePopup: closePopup,
                )
              ],
            )),
      ),
    );
  }

  void closePopup() {
    setState(() {
      contactMenuOpen = false;
    });
  }

  void openContactMenu() {
    setState(() {
      contactMenuOpen = true;
    });
  }
}

class PopupMenu extends StatelessWidget {
  final bool open;
  final Function closePopup;

  PopupMenu({this.open, this.closePopup});

  @override
  Widget build(BuildContext context) {
    if (open) {
      return Center(
        child: Container(
          alignment: Alignment(0.0, 0.0),
          
          child: Container(
            decoration: BoxDecoration (color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: EdgeInsets.symmetric(horizontal: 30),
            
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    closePopup();
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 10, top: 10),
                    child: Container(
                      child: Icon(Icons
                          .close, size: 30,),
                    ),
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL("tel://5026001004");
                  },
                  child: Row(
                                  mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.phone),
                      Container(
                        
                        child: Text('Call', style: TextStyle(fontSize: 20)),
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL('sms:+5026001004?body=');
                  },
                  child: Row(
                                  mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.sms),
                      Container(
                        child: Text('Text', style: TextStyle(fontSize: 20)),
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL(
                        'mailto:c.chamberlain@bbfarmky.com?subject=Inquiry&body=<body>');
                  },
                  child: Container(
                    child: Row(
                                    mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.email),
                        Text('Email', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      height: 0,
      width: 0,
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
