import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/models/product_model.dart';
import 'package:tesla_ecommerce_app/screens/product_screen/components/product_image_carousel.dart';
import 'package:tesla_ecommerce_app/screens/product_screen/components/product_price.dart';
import 'package:tesla_ecommerce_app/screens/product_screen/components/product_style_selector.dart';
import 'package:tesla_ecommerce_app/screens/product_screen/product_screen_providers.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ModalRoute.of(context)!.settings.arguments as Product;
    ref.watch(carouselImageProvider.notifier).update((state) => item.defaultImageUrls);
    ref.watch(productPriceProvider.notifier).update((state) => 
      (item.price != null) ? '\$${item.price}' : '\$${item.priceRange![0]} - \$${item.priceRange![1]}');
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProductImageCarousel(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text(item.title, style: Theme.of(context).textTheme.headlineMedium),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: ProductPrice(),
              ),
              if (item.variantGroups != null) 
                ...item.variantGroups!.map((variantGroup) => 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: ProductStyleSelector(item: item),
                  ),
                ).toList(),
            ],
          )
        )
      )
    );
  }
}