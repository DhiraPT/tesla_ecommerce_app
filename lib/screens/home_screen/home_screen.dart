import 'package:flutter/material.dart';

import 'package:tesla_ecommerce_app/screens/home_screen/components/home_appbar.dart';
import 'package:tesla_ecommerce_app/screens/home_screen/components/product_list_display.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = ['All', 'Cars', 'Charging', 'Vehicle Accessories', 'Apparel', 'Lifestyle'];
    return DefaultTabController(
      length: tabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: HomeAppBar(tabs: tabs),
            )
          ];
        },
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: tabs.map((String name) {
            return ProductListDisplay(tab: name);
          }).toList()
        )
      )
    );
  }
}
