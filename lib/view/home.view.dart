import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rapyd_app/api/status.dart';
import 'package:rapyd_app/view_model/product.vm.dart';


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {

  ProductVM productVM = ProductVM();
  @override
  void initState() {
    super.initState();
    productVM.getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
        title: Text(
          "What would you like to eat?",
          style: TextStyle(
              color: Color(0xFF3a3737),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        actions:[
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Color(0xFF3a3737),
            ),
            onPressed: () {}
          )
        ], 
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      
      body: ChangeNotifierProvider<ProductVM>(
        create: (BuildContext context) => productVM,
        child: Consumer<ProductVM>(
            builder: (context, value, _){
              

              if(value.productModel.status == Status.LOADING){
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 3.0),
                  Text('Loading...')
                ],
              ),
            );
          } else if(value.productModel.status == Status.COMPLETED){
            return Column(
              children: [
                Text(value.productModel.data!.body),
                Text(value.productModel.data!.title),
              ],
            );
          } else {
            return Center(
              child: Text(
                value.productModel.message != null
                  ? value.productModel.message.toString()
                  : 'error'
              ),
            );
          }
            }
        ),
      ),
    );
  }
}


