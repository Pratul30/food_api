import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartVM with ChangeNotifier {
  List<Cart> _carts = [];

  List<Cart> get getCart {
    return [..._carts];
  }

  void addCartItem(String name, String imageUrl, int quantity, double price) {}
}
