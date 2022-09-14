import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/view models/cart.dart';
import '../widgets/cart_list.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int counter = 3;

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartVM>(context);
    var cartMap = cart.getCart;
    var appBar = AppBar(
      backgroundColor: Colors.orange,
      elevation: 0,
      title: Text(
        "Item Carts",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      brightness: Brightness.light,
      actions: <Widget>[
        CartIconWithBadge(),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: cartMap == null
          ? Center(
              child: Text('No Items added. \nGood food is waiting for you.'),
            )
          : ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartMap.length,
                  itemBuilder: ((context, index) =>
                      cartMap.values.toList()[index].quantity < 1
                          ? null
                          : CartList(
                              cartMap.keys.toList()[index],
                              cartMap.values.toList()[index],
                            )),
                ),

                // // ignore: sdk_version_ui_as_code
                // ...cartList
                //     .map(
                //       (e) => e.quantity < 1 ? null : CartList(e),
                //     )
                //     .toList(),
              ],
            ),
    );
  }
}

class CartIconWithBadge extends StatelessWidget {
  int counter = 3;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.shopping_cart,
              // color: Colors.black,
            ),
            onPressed: () {}),
        counter != 0
            ? Positioned(
                right: 5,
                top: 5,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 213, 30, 245),
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
