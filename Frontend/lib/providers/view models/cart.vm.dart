import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartVM with ChangeNotifier {
  Map<String, Cart> _carts = {};
  int totalQuantity = 0;
  double totalAmount = 0;

  Map<String, Cart> get getCart {
    return _carts;
  }

  int get getTotalQuantity {
    return totalQuantity;
  }

  double get getTotalAmount {
    return totalAmount;
  }


  removeAllItems(){
    _carts = {};
    totalAmount = 0;
    totalQuantity = 0;

    notifyListeners();
  }

  void addCartItem(String id, {String name, String imageUrl, double price}) {
    if (_carts.containsKey(id)) {
      _carts.update(id, (previous) {
        totalQuantity = totalQuantity + 1;
        totalAmount = totalAmount + previous.price;
        return Cart(
          cartId: previous.cartId,
          imageUrl: previous.imageUrl,
          name: previous.name,
          price: previous.price,
          quantity: previous.quantity + 1,
        );
      });
    } else {
      _carts.putIfAbsent(id, () {
        totalQuantity = totalQuantity + 1;
        totalAmount = totalAmount + price;
        return Cart(
          cartId: DateTime.now().toString(),
          imageUrl: imageUrl,
          name: name,
          price: price,
          quantity: 1,
        );
      });
    }
    notifyListeners();
  }

  void subtractCartItem(String id) {
    if (_carts.containsKey(id)) {
      _carts.update(id, (previous) {
        totalQuantity = totalQuantity - 1;
        totalAmount = totalAmount - previous.price;
        return Cart(
          cartId: previous.cartId,
          imageUrl: previous.imageUrl,
          name: previous.name,
          price: previous.price,
          quantity: previous.quantity - 1,
        );
      });
    }
    notifyListeners();
  }

  void removeCartItem(String id) {
    totalQuantity = totalQuantity - _carts[id].quantity;
    totalAmount = totalAmount - _carts[id].price;
    _carts.remove(id);
    notifyListeners();
  }
}
