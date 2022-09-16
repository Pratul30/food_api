import 'package:flutter/material.dart';

class SearchInputWidget extends StatelessWidget {
  final Function(String) onChanged;
  final Function clear;
  final String placeholder;
  final TextEditingController searchCtrl;
  
  const SearchInputWidget({ 
    Key key, @required this.onChanged, @required 
    this.clear, @required this.searchCtrl,
    @required this.placeholder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: (){
            clear();
          },
        ),
        hintText: placeholder,
        hintStyle: const TextStyle(),
        fillColor: Colors.grey[200],
        filled:true,
        // border: const OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(0.0)),
        //   borderSide: BorderSide.none
        // ),
        border: InputBorder.none
      ),
      controller: searchCtrl,
      onChanged: (value) => onChanged(value),
    );
  }
}