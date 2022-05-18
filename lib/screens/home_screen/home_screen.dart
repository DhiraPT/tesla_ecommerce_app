import 'package:flutter/material.dart';

import 'package:tesla_ecommerce_app/screens/home_screen/components/home_appbar.dart';
import 'package:tesla_ecommerce_app/screens/home_screen/components/product_category_tabs.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              const HomeAppBar(),
              ProductCategoryTabs(),
            ]
          )
        )
      ),
    );
  }
}