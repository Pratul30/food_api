import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/view models/cart.vm.dart';
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
      actions: <Widget>[
        CartIconWithBadge(),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: WidgetsUi().button(
                      child: Text(
                        'Pay \$ ${cart.getTotalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                      ),
                      width: double.infinity,
                      shape: 10.0,
                      outlineColor: Colors.transparent,
                      color: Colors.orange,
                      overColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CardScreen(
                            amountToPay: cart.getTotalAmount.toStringAsFixed(2),
                          ),
                        ));
                      }),
                )
              ],
            ),
    );
  }
}
