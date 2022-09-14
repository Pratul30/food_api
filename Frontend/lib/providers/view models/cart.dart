import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartVM with ChangeNotifier {
  Map<String, Cart> _carts = {};

  Map<String, Cart> get getCart {
    return _carts;
  }

  void addCartItem(String id, {String name, String imageUrl, double price}) {
    if (_carts.containsKey(id)) {
      _carts.update(
          id,
          (previous) => Cart(
                cartId: previous.cartId,
                imageUrl: previous.imageUrl,
                name: previous.name,
                price: previous.price,
                quantity: previous.quantity + 1,
              ));
    } else {
      _carts.putIfAbsent(
        id,
        () => Cart(
          cartId: DateTime.now().toString(),
          imageUrl: imageUrl,
          name: name,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void subtractCartItem(String id) {
    if (_carts.containsKey(id)) {
      _carts.update(
          id,
          (previous) => Cart(
                cartId: previous.cartId,
                imageUrl: previous.imageUrl,
                name: previous.name,
                price: previous.price,
                quantity: previous.quantity - 1,
              ));
    }
    notifyListeners();
  }

  void removeCartItem(String id) {
    _carts.remove(id);
    notifyListeners();
  }
}
