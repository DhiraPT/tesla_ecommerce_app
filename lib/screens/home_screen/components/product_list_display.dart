import 'package:flutter/material.dart';

import 'package:tesla_ecommerce_app/models/product_model.dart';
import 'package:tesla_ecommerce_app/screens/home_screen/components/product_card.dart';
import 'package:tesla_ecommerce_app/utils/firestore_service.dart';

class ProductListDisplay extends StatefulWidget {
  final String tab;
  const ProductListDisplay({Key? key, required this.tab}) : super(key: key);

  @override
  State<ProductListDisplay> createState() => _ProductListDisplayState();
}

class _ProductListDisplayState extends State<ProductListDisplay> {
  late FirestoreService firestoreService;

  @override
  void initState() {
    super.initState();
    firestoreService = FirestoreService();
  }

  Widget productListDisplayAll(double itemHeight, double itemWidth) {
    return FutureBuilder(
      future: firestoreService.getAllProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        } else if (snapshot.hasData) {
          var productItems = snapshot.data as List<Product>;
          return CustomScrollView(
            primary: false,
            slivers: [
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                    childAspectRatio: (itemWidth / itemHeight),
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ProductCard(item: productItems[index], itemHeight: itemHeight, itemWidth: itemWidth);
                    },
                    childCount: productItems.length,
                  )
                )
              )
            ]
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
            )
          );
        }
      }
    );
  }

  Widget productListDisplayOthers(double itemHeight, double itemWidth) {
    return const Text('Others');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth * 1.5;

    return (widget.tab == 'All')
      ? productListDisplayAll(itemHeight, itemWidth)
      : productListDisplayOthers(itemHeight, itemWidth);
  }
}
