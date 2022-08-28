import 'package:flutter/material.dart';

class Menu {
  String id;
  String name;
  String description;
  String imageUrl;

  Menu({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

class MenuVM with ChangeNotifier {
  List<Menu> resList = [
    Menu(
      id: "001",
      name: "Burger",
      description: "",
      imageUrl: "https://picsum.photos/250?image=9"
    ),

    Menu(
      id: "002",
      name: "Pizza",
      description: "",
      imageUrl: "https://picsum.photos/250?image=9"
    ),

    Menu(
      id: "003",
      name: "Fataya",
      description: "",
      imageUrl: "https://picsum.photos/250?image=9"
    ),
  ];

  List<Menu> get menu {
    return [...resList];
  }
}
