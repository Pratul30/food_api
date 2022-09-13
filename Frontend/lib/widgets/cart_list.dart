import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/view models/cart.dart';

class CartList extends StatelessWidget {
  const CartList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartVM>(context);
    var cartMap = cart.getCart;
    return Container();
  }
}
