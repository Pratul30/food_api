import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/view models/cart.dart';
import '../screens/CardScreen.dart';
import '../widgets/cart_list.dart';
import '../widgets/cart_badge.dart';

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
          fontSize: 20,
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
      body: cart.getTotalQuantity == 0
          ? Center(
              child: Text('No Items added. \nGood food is waiting for you.'),
            )
          : ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Your Food',
                              style: TextStyle(
                                  fontFamily: 'Times New Roman',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.purple),
                            ),
                          ),
                          SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cartMap.length,
                            itemBuilder: ((context, index) =>
                                cartMap.values.toList()[index].quantity < 1
                                    ? null
                                    : CartList(
                                        cartMap.keys.toList()[index],
                                        cartMap.values.toList()[index],
                                      )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Billing Details',
                              style: TextStyle(
                                  fontFamily: 'Times New Roman',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.purple),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Items'),
                                Text(cartMap.length.toString()),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Quantity'),
                                Text(cart.getTotalQuantity.toString()),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payable Amount',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$ ${cart.getTotalAmount.toStringAsFixed(2).toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CardScreen(),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    height: 50,
                    child: Card(
                      color: Colors.orange,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Pay \$ ${cart.getTotalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
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
