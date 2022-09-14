import 'package:flutter/material.dart';
import '../providers/models/cart.dart';
import 'package:provider/provider.dart';

import '../providers/view models/cart.dart';

class CartList extends StatefulWidget {
  final Cart cart;
  final String cartKey;
  CartList(this.cartKey, this.cart);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    final cartListener = Provider.of<CartVM>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 75,
                width: 75,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  widget.cart.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.cart.name,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.cart.quantity > 1
                                ? cartListener.subtractCartItem(widget.cartKey)
                                : cartListener.removeCartItem(widget.cartKey);
                          },
                          icon: Icon(
                            Icons.indeterminate_check_box,
                            color: Colors.purple,
                          ),
                        ),
                        Text(
                          '${widget.cart.quantity}',
                        ),
                        IconButton(
                          onPressed: () {
                            cartListener.addCartItem(widget.cartKey);
                          },
                          icon: Icon(
                            Icons.add_box,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                    Text(
                        'Amount: \$ ${(widget.cart.price * widget.cart.quantity).toStringAsFixed(2)}')
                  ],
                ),
              )
            ],
          ),
        ),
        elevation: 3,
      ),
    );
  }
}
