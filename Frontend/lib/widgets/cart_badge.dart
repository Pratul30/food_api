import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/view models/cart.vm.dart';

class CartIconWithBadge extends StatelessWidget {
  int counter;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartVM>(context);
    counter = cart.getTotalQuantity;
    return Stack(
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.shopping_cart,
              // color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('cart_screen');
            }),
        counter != 0
            ? Positioned(
                right: 5,
                top: 5,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$counter',
                    style: TextStyle(
                      // color: Colors.red,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
