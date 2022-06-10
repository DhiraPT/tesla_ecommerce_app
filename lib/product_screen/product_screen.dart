import 'package:flutter/material.dart';
import 'package:tesla_ecommerce_app/models/product_model.dart';

import 'package:tesla_ecommerce_app/product_screen/components/product_image_carousel.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Product;
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
              ProductImageCarousel(imageUrls: item.imageUrls ?? item.variantGroups![0].variants[0].imageUrls ?? []),
            ],
          )
        )
      )
    );
  }
}