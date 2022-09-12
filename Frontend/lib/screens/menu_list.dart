import 'package:flutter/material.dart';
import 'package:flutter_app/providers/menu.dart';
import 'package:flutter_app/widgets/loading.widget.dart';
import 'package:provider/provider.dart';

class MenuListScreen extends StatefulWidget {
  MenuListScreen(this.id);
  final id;

  @override
  State<MenuListScreen> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MenuVM>(context, listen: false).getMenuList(widget.id['id']);
  }

  @override
  Widget build(BuildContext context) {
    final menuList = Provider.of<MenuVM>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.orange,
          title: Text("Menu list"),
          centerTitle: false,
        ),
        //backgroundColor: Color.fromARGB(255, 252, 241, 241),
        body: menuList.loadingMenuList
            ? Center(child: LoadingWidget())
            : menuList.menuList.length != 0
                ? _buildMenuList(menuList.menuList)
                : menuList.menuListError != ""
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
                            menuList.menuListError,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ))
                    : Center(
                        child: Text(
                          "no data found",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[800],
                          ),
                        ),
                      ));
  }

  Widget _buildMenuList(List data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      data[index]['data']['sizes'][0]['url'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index]['data']['caption'].toString(),
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(height: 15),
                        // Row(
                        //   children: [
                        //     Icon(Icons.star,
                        //         size: 30, color: Colors.amber[700]),
                        //     SizedBox(width: 5),
                        //     Text(
                        //       "3.7 (1k+) - 40mins",
                        //       style: TextStyle(
                        //         fontSize: 18.0,
                        //         fontWeight: FontWeight.bold,
                        //         overflow: TextOverflow.ellipsis,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 10),
                        // Text(
                        //   "Ullamco enim mollit exercitation enim diat amet.",
                        //   style: TextStyle(
                        //     color: Colors.grey[600],
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),
                        // SizedBox(height: 10),
                        Text(
                          "\$130",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: RaisedButton(
                                  onPressed: () {},
                                  child: Text('Add To Cart'),
                                  color: Colors.purple,
                                  textColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
