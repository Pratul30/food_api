import 'package:flutter/material.dart';
import 'package:flutter_app/api/menu.api.dart';
import '../models/menu_list.dart';

class MenuListVM with ChangeNotifier {
  bool loadingMenuList = false;
  String menuListError = "";
  List<MenuList> menuList = [];

  List<MenuList> get getterMenuList {
    return [...menuList];
  }

  fetchMenuList(String id) async {
    var albumList = [];
    List<MenuList> tempList = [];
    print('loading....');
    loadingMenuList = true;
    try {
      var data = await MenuApi.getMenus(id);
      if (data[2] >= 200 || data[2] <= 299) {
        //menuList.clear();
        albumList = data[0]['data']['AppPresentation_queryAppDetailV2'][0]
            ['sections'][0]['albumPhotos'];
        albumList.forEach((element) {
          tempList.add(MenuList(
            imageUrl: element['data']['sizes'][0]['url'],
            dishName: element['data']['caption'].toString(),
            id: element['data']['id'].toString(),
          ));
        });
        menuList = tempList;
      } else {
        menuListError = data[1];
      }
    } on Exception catch (e) {
      debugPrint('[ON EXCEPTION CATCH]\n$e');
      menuListError = e.toString();
    } on Error catch (e) {
      debugPrint('[ON ERROR CATCH]\n$e');
      menuListError = e.toString();
    } finally {
      loadingMenuList = false;
      print('fianlly...');
    }

    notifyListeners();
  }
}
