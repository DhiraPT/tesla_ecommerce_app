import 'package:flutter/material.dart';

class ProductListDisplay extends StatelessWidget {
  final String tab;
  const ProductListDisplay({Key? key, required this.tab}) : super(key: key);

  Widget productListDisplayAll(double itemHeight, double itemWidth) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: (itemWidth / itemHeight),
        children: const [Text("all")]
      ),
    );
  }

  Widget productListDisplayOthers(double itemHeight, double itemWidth) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: (itemWidth / itemHeight),
        children: const [Text("others")]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    if (tab == 'All') {
      return productListDisplayAll(itemHeight, itemWidth);
    } else {
      return productListDisplayOthers(itemHeight, itemWidth);
    }
  }
}
