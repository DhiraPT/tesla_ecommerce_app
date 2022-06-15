import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/screens/product_screen/product_screen_providers.dart';

class ProductPrice extends ConsumerWidget {
  const ProductPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final price = ref.watch(productPriceProvider);
    return Text(price);
  }
}
