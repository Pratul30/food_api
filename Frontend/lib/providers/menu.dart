import 'package:flutter/cupertino.dart';
import 'package:flutter_app/api/menu.api.dart';

class Menu {
  String id;
  String name;
  String description;
  String imageUrl;
  String slug;

  Menu(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.imageUrl,
      @required this.slug});
}

class MenuVM extends ChangeNotifier {
  List<Menu> get menu => menuIcons;

  List<Menu> menuIcons = [
    Menu(
        id: "001",
        name: "Seafood",
        imageUrl: "assets/images/topmenu/ic_burger.png",
        slug: "",
        description: ""),
    Menu(
        id: "002",
        name: "International",
        imageUrl: "assets/images/topmenu/ic_sushi.png",
        slug: "",
        description: ""),
    Menu(
        id: "003",
        name: "Asian",
        imageUrl: "assets/images/topmenu/ic_pizza.png",
        slug: "",
        description: ""),
    Menu(
        id: "004",
        name: "Bar",
        imageUrl: "assets/images/topmenu/ic_cake.png",
        slug: "",
        description: ""),
    Menu(
        id: "005",
        name: "Cafe",
        imageUrl: "assets/images/topmenu/ic_ice_cream.png",
        slug: "",
        description: ""),
    Menu(
        id: "006",
        name: "European",
        imageUrl: "assets/images/topmenu/ic_soft_drink.png",
        slug: "",
        description: ""),
    Menu(
        id: "007",
        name: "Gastropub",
        imageUrl: "assets/images/topmenu/ic_burger.png",
        slug: "",
        description: ""),
    Menu(
        id: "008",
        name: "Fusion",
        imageUrl: "assets/images/topmenu/ic_sushi.png",
        slug: "",
        description: ""),
  ];
}
