import 'package:flutter/material.dart';

import 'package:tesla_ecommerce_app/screens/shopping_cart_screen/components/shopping_cart_appbar.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        ShoppingCartAppBar(),
      ],
    );
  }
}