import 'package:flutter/material.dart';
import 'package:flutter_app/providers/view%20models/payment.vm.dart';
import 'package:flutter_app/widgets/loading.widget.dart';
import 'package:provider/provider.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String currency;
  PaymentMethodScreen({Key key, @required this.currency}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PaymentVM>(context, listen: false).paymentListByCountry(widget.currency);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final _payment = Provider.of<PaymentVM>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Payment Method',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.grey[100],
      body: _payment.isLoading
      ? Center(child: LoadingWidget())
      : _payment.paymentMethod.length != 0
      ? ListView.builder(
        itemCount: _payment.paymentMethod.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              child: listPaymentMethods(_payment.paymentMethod[index]),
              onTap: (){
                Navigator.pop(context, {
                  'type': _payment.paymentMethod[index]['type'],
              });
              },
            ),
          );
        },
      )
      : _payment.error != ""
        ? Center(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/close.png',
                height: 65.0,
                width: 65.0,
                color: Colors.grey[600],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                _payment.error,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ))
        : Center(
            child: Text(
              "No payment method\nfound",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
          )
    );
  }

  Widget listPaymentMethods(var data){
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.deepPurple[600], width: 5.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Image.network(
              data['image'],
              width: double.infinity,
              height: MediaQuery.of(context).size.width/2,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.deepPurple[600],
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
              child: Text(
                  data['full_name'],
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  )
                )
              )
          )
        ],
      ),
    );
  }
}
