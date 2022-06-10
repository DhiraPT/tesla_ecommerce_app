import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final carouselIndexProvider = StateProvider<int>(
  (ref) => 0,
);

class ProductImageCarousel extends ConsumerStatefulWidget {
  final List<String> imageUrls;
  const ProductImageCarousel({Key? key, required this.imageUrls}) : super(key: key);

  @override
  ConsumerState<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends ConsumerState<ProductImageCarousel> {
  late CarouselController _carouselController;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  List<Widget> imageSliders() {
    return widget.imageUrls
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
  Widget build(BuildContext context) {
    final carouselIndex = ref.watch(carouselIndexProvider);
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CarouselSlider(
          items: imageSliders(),
          carouselController: _carouselController,
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
                  '$carouselIndex/${widget.imageUrls.length}',
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
