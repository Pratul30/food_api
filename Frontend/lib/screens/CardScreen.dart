import 'package:flutter/material.dart';
import 'package:flutter_app/providers/view%20models/cart.vm.dart';
import 'package:flutter_app/providers/view%20models/payment.vm.dart';
import 'package:flutter_app/screens/countriesScreen.dart';
import 'package:flutter_app/screens/paymentMethodScreen.dart';
import 'package:flutter_app/widgets/widgets.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';

class CardScreen extends StatefulWidget {
  String amountToPay;
  CardScreen({Key key, @required this.amountToPay}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String currency = 'USD';
  String cardType = '';
  String country = "United States of America";
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      expiryDate = creditCardModel.expiryDate;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
    isFilled();
  }

  bool isFilled() {
    if (cardNumber != '' &&
        expiryDate != '' &&
        cardHolderName != '' &&
        currency != '' &&
        cardType != '' &&
        cvvCode != '') return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final _payment = Provider.of<PaymentVM>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Payment',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                child: Text('Enter your details',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue[700],
                    )),
              ),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                onCreditCardWidgetChange: ((_) {}),
                isHolderNameVisible: true,
                cardBgColor: Colors.purple,
                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                    cardType: CardType.mastercard,
                    cardImage: Image.asset(
                      'assets/mastercard.png',
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CreditCardForm(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                onCreditCardModelChange: onCreditCardModelChange,
                themeColor: Colors.black,
                formKey: formKey,
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {

                      final params = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: true, builder: (context) => CountriesScreen(value: 'currency')
                        ),
                      );
                      if(!mounted) return;
                      setState(() {
                        currency = params['currency'];
                        country = params['country'];
                      });
                        
                      Future.delayed(Duration(seconds: 1),() async {
                        final params = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true, builder: (context) => PaymentMethodScreen(currency: currency)
                          ),
                        );
                        if(!mounted) return;
                        print(params['type']);
                        setState(() {
                          cardType = params['type'];
                        });
                      });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  currency,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Text("($country)"),
                              ],
                            ),
                            Icon(Icons.chevron_right, color: Colors.grey[600]),
                          ],
                        ),
                      ),
                    ),
                    Divider(thickness: 2.0, color: Colors.grey[400]),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: WidgetsUi().button(
                    child: _payment.isLoading
                        ? SizedBox(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 3.0,
                            ),
                            height: 30,
                            width: 30,
                          )
                        : Text(
                            "Pay",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                    width: double.infinity,
                    outlineColor: Colors.transparent,
                    color: isFilled() ? Colors.orange : Colors.grey[500],
                    overColor: Colors.white,
                    onPressed: () async {
                      if (isFilled() && !_payment.isLoading) {
                        var data = {
                          "amount": widget.amountToPay,
                          "currency": currency,
                          "payment_method": {
                            "type": cardType,
                            "fields": {
                              "number": cardNumber,
                              "expiration_month": expiryDate.substring(0, 2),
                              "expiration_year": expiryDate.substring(3, 5),
                              "name": cardHolderName,
                              "cvv": cvvCode
                            }
                          }
                        };
                        await _payment.paymentCard(data);
                      }
                      if (_payment.error != "") {
                        WidgetsUi().toast(
                            context: context,
                            message: _payment.error,
                            bColor: Colors.red);
                      } else if (_payment.status == 200) {
                        WidgetsUi().toast(
                            context: context,
                            message: "success",
                            bColor: Colors.greenAccent);

                        Future.delayed(Duration(seconds: 2), () {
                          /// remove items in cart
                          Provider.of<CartVM>(context, listen: false)
                              .removeAllItems();

                          /// go back to the [Home] page
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'home', (route) => false);
                        });
                      }
                    }),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
