import 'package:bbfarmky/products/product.dart';

class Cart {
  static List<Product> cart = [];
  static Map<String, int> _cart = new Map<String, int>();

  void toggleItem(Product product) {
    if(this.containsProduct(product))
      this.removeProduct(product);
    else
      this._addProduct(product);
  }

  void empty() {
    cart = [];
    _cart.clear();
  }

  getProductQuantityMap() {
    return _cart;
  }

  bool containsProduct(Product product) {
    for(int i = 0; i < cart.length; i++) {
      if(cart[i].id == product.id)
        return true;
    }
    return false;
  }

  bool isEmpty() {
    if(cart.length == 0)
      return true;
    return false;
  }

  int getNumItems() {
    return cart.length;  
  }

  List<Product> getProducts() {
    return cart;
  }

  List<String> getProductIDs() {
    List<String> ids = [];
    for(int i = 0; i < cart.length; i++) {
      ids.add(cart[i].id);
    }
    return ids;
  }

  void updateQuantity(Product product, int quantity) {
    _cart[product.id] = quantity;
  }

  int getQuantity(Product product) {
    return _cart[product.id];
  }

  void debugPrint() {
    print('--------- CART DEBUG ---------');
    cart.forEach((product) => print(product.name));
    print('--------- END DEBUG ----------');
  }

  void _addProduct(Product product) {
    cart.add(product);
    _cart[product.id] = 1;
  }

  void removeProduct(Product product) {
    _cart.remove(product.id);

    for(int i = 0; i < cart.length; i++) 
      if(cart[i].id == product.id)
        cart.removeAt(i);
  }


}
