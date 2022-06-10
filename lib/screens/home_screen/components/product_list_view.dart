import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/providers/firestore_provider.dart';

import 'package:tesla_ecommerce_app/screens/home_screen/components/product_card.dart';
import 'package:tesla_ecommerce_app/screens/home_screen/components/subcategory_card.dart';

class ProductListView extends ConsumerWidget {
  final String tab;
  const ProductListView({Key? key, required this.tab}) : super(key: key);

  Widget productListViewAll(BuildContext context, WidgetRef ref, double itemHeight, double itemWidth) {
    final productItems = ref.watch(allProductsProvider);
    return productItems.when(
      data: (productItems) {
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
                    return ProductCard(item: productItems[index], itemWidth: itemWidth, size: 'big');
                  },
                  childCount: productItems.length,
                )
              )
            )
          ]
        );
      },
      error: (Object error, StackTrace? stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.black),
          )
        );
      }
    );
  }

  Widget productListViewOthers(BuildContext context, WidgetRef ref, double itemHeight, double itemWidth, String category) {
    final subcategoryItems = ref.watch(subcategoriesProvider(category));
    return subcategoryItems.when(
      data: (subcategoryItems) {
        return CustomScrollView(
          primary: false,
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index != subcategoryItems.length - 1) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: SubcategoryCard(category: category, name: subcategoryItems[index], itemWidth: itemWidth * 0.8, itemHeight: itemHeight * 0.8),
                      );
                    } else {
                      return SubcategoryCard(category: category, name: subcategoryItems[index], itemWidth: itemWidth * 0.8, itemHeight: itemHeight * 0.8);
                    }
                  },
                  childCount: subcategoryItems.length,
                )
              )
            )
          ]
        );
      },
      error: (Object error, StackTrace? stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.black),
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth * 1.5;
    return (tab == 'All')
      ? productListViewAll(context, ref, itemHeight, itemWidth)
      : productListViewOthers(context, ref, itemHeight, itemWidth, tab);
  }
}
