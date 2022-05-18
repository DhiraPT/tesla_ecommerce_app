import 'package:flutter/material.dart';

class HomeSearchBox extends StatefulWidget {
  const HomeSearchBox({Key? key}) : super(key: key);

  @override
  HomeSearchBoxState createState() => HomeSearchBoxState();
}

class HomeSearchBoxState extends State<HomeSearchBox> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: _textEditingController,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
          filled: true,
          fillColor: const Color.fromRGBO(240, 240, 240, 1.0),
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          hintText: 'Search products',
          hintStyle: const TextStyle(color: Color.fromRGBO(162, 162, 162, 1.0)),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Color.fromRGBO(240, 240, 240, 1.0)),
            borderRadius: BorderRadius.circular(10.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Color.fromRGBO(240, 240, 240, 1.0)),
            borderRadius: BorderRadius.circular(10.0)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Color.fromRGBO(162, 162, 162, 1.0)),
            borderRadius: BorderRadius.circular(10.0)
          ),
          suffixIcon: (_textEditingController.text.trim().isEmpty
            ? null
            : IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: const Icon(Icons.clear, color: Color.fromRGBO(162, 162, 162, 1.0)),
              onPressed: () => setState(
                () {
                  _textEditingController.clear();
                },
              ),
            )
          )
        ),
      ),
    );
  }
}
