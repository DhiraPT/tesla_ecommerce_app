import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/models/product_model.dart';
import 'package:tesla_ecommerce_app/providers/firebase_auth_provider.dart';
import 'package:tesla_ecommerce_app/providers/firestore_provider.dart';
import 'package:tesla_ecommerce_app/screens/product_screen/components/product_description.dart';
import 'package:tesla_ecommerce_app/screens/product_screen/components/product_image_carousel.dart';
import 'package:tesla_ecommerce_app/screens/product_screen/components/product_style_selector.dart';
import 'package:tesla_ecommerce_app/screens/product_screen/product_screen_providers.dart';
import 'package:tuple/tuple.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ModalRoute.of(context)!.settings.arguments as Product;
    final price = ref.watch(productPriceProvider);
    final quantity = ref.watch(productQuantityProvider);
    List<String> variantGroups = [];
    if (item.variantGroups != null) {
      for (var variantGroup in item.variantGroups!) {
        variantGroups.add(variantGroup.name);
      }
    }
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
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
                child: Text(item.title, style: Theme.of(context).textTheme.headlineMedium),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(price, style: Theme.of(context).textTheme.titleLarge),
              ),
              for (var name in variantGroups) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
                  child: (() {
                    if (name == 'styles') {
                      return ProductStyleSelector(item: item);
                    } else if (name == 'colors') {
                      //ProductColorSelector();
                    } else if (name == 'sizes') {
                      //ProductSizeSelector();
                    }
                  } ())
                )
              ],
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 4.0),
                child: Text('Quantity', style: Theme.of(context).textTheme.titleMedium),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: (quantity == 1) ? null
                        : () => ref.watch(productQuantityProvider.notifier).update((state) => state - 1),
                    ),
                    SizedBox(
                      width: 40.0,
                      child: Center(child: Text(quantity.toString(), style: Theme.of(context).textTheme.titleMedium)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => ref.watch(productQuantityProvider.notifier).update((state) => state + 1),
                    ),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: TextButton(
                  onPressed: () {
                    final authState = ref.read(authStateProvider);
                    if (variantGroups.isNotEmpty) {
                      final productStyle = ref.read(productStyleProvider.notifier).state;
                      if (variantGroups.contains('styles') && productStyle == null) {
                        EasyLoading.showInfo('Please select a style');
                      } else if (variantGroups.contains('colors')) {
                        //ProductColorSelector();
                      } else if (variantGroups.contains('sizes')) {
                        //ProductSizeSelector();
                      } else {
                        if (authState.asData?.value != null) {
                          ref.watch(addToCartProvider(Tuple4(authState.asData!.value!.uid, item.id, quantity, productStyle)).future)
                          .then((msg) {
                            if (msg == 'Item successfully added to cart') {
                              EasyLoading.showSuccess(msg);
                            } else {
                              EasyLoading.showInfo(msg);
                            }
                          })
                          .onError((error, stackTrace) {
                            Center(child: Text(error.toString()));
                          });
                        } else {
                          //If not logged in
                          EasyLoading.showInfo('Please log in first');
                        }
                      }
                    } else {
                      if (authState.asData?.value != null) {
                        ref.watch(addToCartProvider(Tuple4(authState.asData!.value!.uid, item.id, quantity, null)).future)
                        .then((msg) {
                          if (msg == 'Item successfully added to cart') {
                            EasyLoading.showSuccess(msg);
                          } else {
                            EasyLoading.showInfo(msg);
                          }
                        })
                        .onError((error, stackTrace) {
                          Center(child: Text(error.toString()));
                        });
                      } else {
                        //If not logged in
                        EasyLoading.showInfo('Please log in first');
                      }
                    }
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                    backgroundColor: Colors.black,
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text('Add to Cart', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white))
                )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
                child: Text('Description', style: Theme.of(context).textTheme.titleMedium),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ProductDescription(description: item.description),
              ),
            ],
          )
        )
      )
    );
  }
}