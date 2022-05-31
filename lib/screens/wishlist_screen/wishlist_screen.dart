import 'package:flutter/material.dart';

import 'package:tesla_ecommerce_app/screens/wishlist_screen/components/wishlist_appbar.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        WishlistAppBar(),
      ],
    );
  }
}