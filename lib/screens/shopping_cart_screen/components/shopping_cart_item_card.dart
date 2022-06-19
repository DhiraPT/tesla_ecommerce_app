import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/models/user_model.dart';
import 'package:tesla_ecommerce_app/providers/firebase_auth_provider.dart';
import 'package:tesla_ecommerce_app/providers/firestore_provider.dart';
import 'package:tesla_ecommerce_app/screens/shopping_cart_screen/shopping_cart_provider.dart';
import 'package:tuple/tuple.dart';

class ShoppingCartItemCard extends ConsumerWidget {
  final int index;
  final ShoppingCartItem shoppingCartItem;
  const ShoppingCartItemCard({Key? key, required this.index, required this.shoppingCartItem}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(productProvider(shoppingCartItem.productId));
    return item.when(
      data: (item) {
        int price;
        String imageUrl;
        if (item!.price == null) {
          price = item.variantGroups!.firstWhere((e) => e.name == 'styles').variants
            .firstWhere((e) => e.name == shoppingCartItem.variant!['style']).price!;
        } else {
          price = item.price!;
        }
        imageUrl = (item.imageUrls != null) ? item.imageUrls![0] 
          : item.variantGroups!.firstWhere((e) => e.name == 'styles').variants
          .firstWhere((e) => e.name == shoppingCartItem.variant!['style']).imageUrls![0];
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: ref.watch(selectedItemProvider(index)),
                    onChanged: (value) => ref.watch(selectedItemProvider(index).notifier).state = value!
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
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
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style: Theme.of(context).textTheme.titleMedium, overflow: TextOverflow.ellipsis, maxLines: 1,),
                          (shoppingCartItem.variant != null) 
                            ? Text(shoppingCartItem.variant!.values.toList().join(', ')) 
                            : const SizedBox(),
                          Text('\$$price', style: Theme.of(context).textTheme.labelLarge),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {ref.watch(changeItemQuantityProvider(Tuple3(ref.watch(authStateProvider).asData!.value!.uid, index, 'minus')));}
                              ),
                              SizedBox(
                                width: 40.0,
                                child: Center(child: Text(shoppingCartItem.quantity.toString(), style: Theme.of(context).textTheme.labelLarge)),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {ref.watch(changeItemQuantityProvider(Tuple3(ref.watch(authStateProvider).asData!.value!.uid, index, 'add')));},
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  )
                ],
              ),
            )
          )
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
}