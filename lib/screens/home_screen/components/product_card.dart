import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tesla_ecommerce_app/models/product_model.dart';
import 'package:tesla_ecommerce_app/screens/product_screen/product_screen_providers.dart';

class ProductCard extends ConsumerWidget {
  final Product item;
  final double itemWidth;
  final String size;
  const ProductCard({Key? key, required this.item, required this.itemWidth, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: (){
        ref.watch(carouselImageProvider.notifier).update((state) => item.defaultImageUrls);
        ref.watch(productPriceProvider.notifier).update((state) => 
          (item.price != null) ? '\$${item.price}' : '\$${item.priceRange![0]} - \$${item.priceRange![1]}');
        Navigator.pushNamed(
          context,
          '/product',
          arguments: item,
        );
      },
      child: SizedBox(
        width: itemWidth,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(225, 225, 225, 1.0),
                spreadRadius: 0.0,
                blurRadius: 8.0,
              )
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: itemWidth,
                  height: itemWidth,
                  child: Image.network(
                    item.defaultImageUrls[0],
                    fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                            valueColor: const AlwaysStoppedAnimation(Colors.black),
                          )
                        );
                      },
                  ),
                ),
                if (size == 'big') ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 4.0, 2.0, 4.0),
                    child: Text(item.title, style: Theme.of(context).textTheme.titleSmall),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 4.0),
                    child: Text(
                      (item.price != null) ? '\$${item.price}' : '\$${item.priceRange![0]} - \$${item.priceRange![1]}',
                      style: Theme.of(context).textTheme.titleSmall
                    ),
                  ),
                ] else if (size == 'small') ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2.0, 2.0, 1.0, 2.0),
                    child: Text(item.title, style: Theme.of(context).textTheme.labelMedium),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 2.0),
                    child: Text(
                      (item.price != null) ? '\$${item.price}' : '\$${item.priceRange![0]} - \$${item.priceRange![1]}',
                      style: Theme.of(context).textTheme.labelMedium
                    ),
                  ),
                ],
              ]
            ),
          )
        )
      )
    );
  }
}
