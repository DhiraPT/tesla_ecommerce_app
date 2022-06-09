import 'package:flutter/material.dart';

import 'package:tesla_ecommerce_app/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product item;
  final double itemWidth;
  final String size;
  const ProductCard({Key? key, required this.item, required this.itemWidth, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  item.defaultImageUrl,
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
                  child: Text('\$${item.price.toString()}', style: Theme.of(context).textTheme.titleSmall),
                ),
              ] else if (size == 'small') ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(2.0, 2.0, 1.0, 2.0),
                  child: Text(item.title, style: Theme.of(context).textTheme.labelMedium),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 2.0),
                  child: Text('\$${item.price.toString()}', style: Theme.of(context).textTheme.labelMedium),
                ),
              ],
            ]
          ),
        )
      )
    );
  }
}
