import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/providers/firestore_provider.dart';
import 'package:tesla_ecommerce_app/screens/home_screen/components/product_card.dart';
import 'package:tuple/tuple.dart';

class SubcategoryCard extends ConsumerStatefulWidget {
  final String category, name;
  final double itemWidth, itemHeight;
  const SubcategoryCard({Key? key, required this.category, required this.name, required this.itemWidth, required this.itemHeight}) : super(key: key);

  @override
  ConsumerState<SubcategoryCard> createState() => _SubcategoryCardState();
}

class _SubcategoryCardState extends ConsumerState<SubcategoryCard> {
  @override
  Widget build(BuildContext context) {
    final productItems = ref.watch(productsOnSubcategoryProvider(Tuple3(widget.category, widget.name, 3)));
    return SizedBox(
      height: widget.itemHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.name, style: Theme.of(context).textTheme.titleLarge),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  child: Text('View More', style: Theme.of(context).textTheme.titleSmall!
                    .copyWith(color: Colors.white))
                ),
              ]
            )
          ),
          Expanded(
            child: productItems.when(
              data: (productItems) {
                return GridView.count(
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 1,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                  childAspectRatio: (widget.itemHeight / widget.itemWidth),
                  clipBehavior: Clip.none,
                  children: productItems.map((productItems) {
                    return ProductCard(item: productItems, itemWidth: widget.itemWidth, size: 'small');
                  }).toList()
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
            )
          )
        ]
      )
    );
  }
}
