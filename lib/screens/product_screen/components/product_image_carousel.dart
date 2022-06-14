import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/screens/product_screen/product_screen_providers.dart';

class ProductImageCarousel extends ConsumerWidget {
  const ProductImageCarousel({Key? key}) : super(key: key);

  List<Widget> imageSliders(List<String> imageUrls) {
    return imageUrls
      .map((imageUrl) => Image.network(
        imageUrl,
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
      )).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carouselIndex = ref.watch(carouselIndexProvider);
    final imageUrls = ref.watch(carouselImageProvider);
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CarouselSlider(
          items: imageSliders(imageUrls),
          options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
            aspectRatio: 1.0,
            onPageChanged: (index, reason) {
              ref.watch(carouselIndexProvider.notifier).update((state) => index);
            }
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: SizedBox(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white.withOpacity(0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                child: Text(
                  '${carouselIndex+1}/${imageUrls.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            ),
          )
        )
      ]
    );
  }
}
